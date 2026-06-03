import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DownloadService {
  static final DownloadService _instance = DownloadService._internal();
  factory DownloadService() => _instance;
  DownloadService._internal();

  final Dio _dio = Dio();

  Future<String> downloadFile({
    required String url,
    required String fileName,
    required Function(double) onProgress,
    CancelToken? cancelToken,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final downloadDir = Directory('${dir.path}/downloads');
    if (!await downloadDir.exists()) {
      await downloadDir.create(recursive: true);
    }
    final savePath = '${downloadDir.path}/$fileName';

    await _dio.download(
      url,
      savePath,
      cancelToken: cancelToken,
      onReceiveProgress: (received, total) {
        if (total > 0) {
          onProgress(received / total);
        }
      },
    );

    return savePath;
  }

  Future<bool> isFileDownloaded(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/downloads/$fileName');
    return await file.exists();
  }

  Future<String?> getDownloadedFilePath(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/downloads/$fileName');
    if (await file.exists()) {
      return file.path;
    }
    return null;
  }

  Future<void> deleteFile(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/downloads/$fileName');
    if (await file.exists()) {
      await file.delete();
    }
  }
}
