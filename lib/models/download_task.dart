enum DownloadStatus { idle, downloading, completed, failed, cancelled }

class DownloadTask {
  final String id;
  final String title;
  final String url;
  final String savePath;
  final String mushafId;
  double progress;
  DownloadStatus status;
  String? errorMessage;
  int? totalBytes;
  int? receivedBytes;
  final DateTime startTime;
  DateTime? completionTime;

  DownloadTask({
    required this.id,
    required this.title,
    required this.url,
    required this.savePath,
    required this.mushafId,
    this.progress = 0.0,
    this.status = DownloadStatus.idle,
    this.errorMessage,
    this.totalBytes,
    this.receivedBytes,
    DateTime? startTime,
    this.completionTime,
  }) : startTime = startTime ?? DateTime.now();

  String get progressText => '${(progress * 100).toStringAsFixed(0)}%';

  String get fileSizeText {
    if (totalBytes == null) return '';
    final mb = totalBytes! / (1024 * 1024);
    return '${mb.toStringAsFixed(1)} م.ب';
  }

  String get receivedSizeText {
    if (receivedBytes == null) return '';
    final mb = receivedBytes! / (1024 * 1024);
    return '${mb.toStringAsFixed(1)} م.ب';
  }

  bool get isActive => status == DownloadStatus.downloading;
  bool get isCompleted => status == DownloadStatus.completed;
  bool get isFailed => status == DownloadStatus.failed;
  bool get isCancelled => status == DownloadStatus.cancelled;

  DownloadTask copyWith({
    double? progress,
    DownloadStatus? status,
    String? errorMessage,
    int? totalBytes,
    int? receivedBytes,
    DateTime? completionTime,
  }) {
    return DownloadTask(
      id: id,
      title: title,
      url: url,
      savePath: savePath,
      mushafId: mushafId,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      totalBytes: totalBytes ?? this.totalBytes,
      receivedBytes: receivedBytes ?? this.receivedBytes,
      startTime: startTime,
      completionTime: completionTime ?? this.completionTime,
    );
  }
}
