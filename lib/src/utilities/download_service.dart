import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

abstract class DownloadService {
  Future<String?> download({required String url, required String? filename});

  factory DownloadService() {
    if (kIsWeb) {
      return WebDownloadService();
    } else {
      return MobileDownloadService();
    }
  }
}

class WebDownloadService implements DownloadService {
  @override
  Future<String?> download({required String url, String? filename}) async {
    html.window.open(url, "_blank");
    return 'success';
  }
}

class MobileDownloadService implements DownloadService {
  @override
  Future<String?> download({required String url, String? filename}) async {
    final task = await DownloadTask(
      url: url,
      updates: Updates.statusAndProgress,
      retries: 5,
      allowPause: true,
    ).withSuggestedFilename(unique: true);

    final result = await FileDownloader()
        .configureNotification(
          running: const TaskNotification('Downloading', 'file: {filename}'),
          complete: const TaskNotification('Download finished', 'file: {filename}'),
          progressBar: true,
        )
        .download(
          task,
          onProgress: (progress) => print('Progress: ${progress * 100}%'),
          onStatus: (status) => print('Status: $status'),
        );
    if (result.status == TaskStatus.complete) {
      await FileDownloader().moveToSharedStorage(task, SharedStorage.downloads);
    }
    return 'success';
  }
}
