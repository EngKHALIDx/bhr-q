import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import '../models/download_task.dart';

class DownloadProvider extends ChangeNotifier {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(minutes: 10),
    followRedirects: true,
    maxRedirects: 5,
    validateStatus: (status) => status != null && status < 400,
    headers: {
      'Accept': 'application/pdf,*/*',
      'User-Agent': 'Mozilla/5.0 (Linux; Android 14) AppleWebKit/537.36',
    },
  ));
  final Map<String, CancelToken> _cancelTokens = {};
  final Map<String, DownloadTask> _tasks = {};

  Map<String, DownloadTask> get tasks => Map.unmodifiable(_tasks);
  List<DownloadTask> get activeTasks =>
      _tasks.values.where((t) => t.isActive).toList();
  List<DownloadTask> get completedTasks =>
      _tasks.values.where((t) => t.isCompleted).toList();
  List<DownloadTask> get allTasks => _tasks.values.toList();

  bool isDownloading(String mushafId) {
    final task = _tasks[mushafId];
    return task != null && task.isActive;
  }

  bool isDownloaded(String mushafId) {
    final task = _tasks[mushafId];
    return task != null && task.isCompleted;
  }

  DownloadTask? getTask(String mushafId) => _tasks[mushafId];

  double getProgress(String mushafId) {
    final task = _tasks[mushafId];
    return task?.progress ?? 0.0;
  }

  Future<String> _getSavePath(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final downloadDir = Directory('${dir.path}/downloads');
    if (!await downloadDir.exists()) {
      await downloadDir.create(recursive: true);
    }
    return '${downloadDir.path}/$fileName';
  }

  String _getErrorMessage(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'انتهت مهلة الاتصال، حاول مرة أخرى';
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          if (statusCode == 404) {
            return 'الملف غير موجود على الخادم (404)';
          } else if (statusCode == 403) {
            return 'غير مصرح بالوصول (403)';
          } else if (statusCode != null && statusCode >= 500) {
            return 'خطأ في الخادم ($statusCode)';
          } else if (statusCode == 302 || statusCode == 301) {
            return 'رابط إعادة توجيه، جرب لاحقاً';
          }
          return 'خطأ في الاستجابة ($statusCode)';
        case DioExceptionType.cancel:
          return 'تم إلغاء التحميل';
        case DioExceptionType.connectionError:
          return 'لا يوجد اتصال بالإنترنت';
        case DioExceptionType.badCertificate:
          return 'مشكلة في شهادة الأمان';
        case DioExceptionType.unknown:
          if (error.error is SocketException) {
            return 'لا يوجد اتصال بالإنترنت';
          }
          return 'حدث خطأ غير متوقع: ${error.message ?? ""}';
      }
    }
    return 'حدث خطأ غير متوقع';
  }

  /// Validate that the URL is reachable before downloading
  Future<bool> _validateUrl(String url) async {
    try {
      final response = await _dio.head(url);
      return response.statusCode != null && response.statusCode! < 400;
    } catch (e) {
      // If HEAD fails, try GET with range header for smaller request
      try {
        await _dio.get(
          url,
          options: Options(headers: {'Range': 'bytes=0-0'}),
        );
        return true;
      } catch (_) {
        return false;
      }
    }
  }

  Future<void> startDownload({
    required String mushafId,
    required String title,
    required String url,
    required String fileName,
  }) async {
    if (isDownloading(mushafId)) return;

    // Check if file already exists
    final savePath = await _getSavePath(fileName);
    final existingFile = File(savePath);
    if (await existingFile.exists()) {
      _tasks[mushafId] = DownloadTask(
        id: mushafId,
        title: title,
        url: url,
        savePath: savePath,
        mushafId: mushafId,
        status: DownloadStatus.completed,
        progress: 1.0,
        receivedBytes: await existingFile.length(),
        totalBytes: await existingFile.length(),
        completionTime: DateTime.now(),
      );
      notifyListeners();
      return;
    }

    final cancelToken = CancelToken();
    _cancelTokens[mushafId] = cancelToken;

    final task = DownloadTask(
      id: mushafId,
      title: title,
      url: url,
      savePath: savePath,
      mushafId: mushafId,
      status: DownloadStatus.downloading,
      progress: 0.0,
    );
    _tasks[mushafId] = task;
    notifyListeners();

    try {
      await _dio.download(
        url,
        savePath,
        cancelToken: cancelToken,
        deleteOnError: true,
        options: Options(
          receiveTimeout: const Duration(minutes: 15),
          followRedirects: true,
          maxRedirects: 5,
        ),
        onReceiveProgress: (received, total) {
          if (total > 0) {
            final progress = received / total;
            _tasks[mushafId] = _tasks[mushafId]!.copyWith(
              progress: progress,
              receivedBytes: received,
              totalBytes: total,
            );
            notifyListeners();
          }
        },
      );

      _tasks[mushafId] = _tasks[mushafId]!.copyWith(
        progress: 1.0,
        status: DownloadStatus.completed,
        receivedBytes: _tasks[mushafId]?.totalBytes,
        completionTime: DateTime.now(),
      );
      _cancelTokens.remove(mushafId);
      notifyListeners();
    } catch (e) {
      // Delete partial file if exists
      final partialFile = File(savePath);
      if (await partialFile.exists()) {
        await partialFile.delete();
      }

      if (e is DioException && e.type == DioExceptionType.cancel) {
        _tasks[mushafId] = _tasks[mushafId]!.copyWith(
          status: DownloadStatus.cancelled,
        );
      } else {
        _tasks[mushafId] = _tasks[mushafId]!.copyWith(
          status: DownloadStatus.failed,
          errorMessage: _getErrorMessage(e),
          progress: 0.0,
        );
      }
      _cancelTokens.remove(mushafId);
      notifyListeners();
    }
  }

  void cancelDownload(String mushafId) {
    final cancelToken = _cancelTokens[mushafId];
    if (cancelToken != null && !cancelToken.isCancelled) {
      cancelToken.cancel('تم إلغاء التحميل');
    }
  }

  Future<void> deleteDownload(String mushafId) async {
    final task = _tasks[mushafId];
    if (task != null) {
      final file = File(task.savePath);
      if (await file.exists()) {
        await file.delete();
      }
      _tasks.remove(mushafId);
      _cancelTokens.remove(mushafId);
      notifyListeners();
    }
  }

  Future<void> retryDownload(String mushafId) async {
    final task = _tasks[mushafId];
    if (task != null && (task.isFailed || task.isCancelled)) {
      _tasks.remove(mushafId);
      notifyListeners();
      await startDownload(
        mushafId: mushafId,
        title: task.title,
        url: task.url,
        fileName: task.savePath.split('/').last,
      );
    }
  }

  Future<void> clearAllDownloads() async {
    for (final task in _tasks.values) {
      if (task.isActive) {
        cancelDownload(task.mushafId);
      }
      if (task.isCompleted) {
        final file = File(task.savePath);
        if (await file.exists()) {
          await file.delete();
        }
      }
    }
    _tasks.clear();
    _cancelTokens.clear();
    notifyListeners();
  }

  String? getLocalPath(String mushafId) {
    final task = _tasks[mushafId];
    if (task != null && task.isCompleted) {
      return task.savePath;
    }
    return null;
  }
}
