import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

abstract class DownloadService {
  Future<String?> download({required String url, required String? filename, required int? bytes});

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
  Future<String?> download({required String url, String? filename, int? bytes}) async {
    html.Blob fileBlob = html.Blob([bytes], 'application/octet-stream');
    final url = html.Url.createObjectUrlFromBlob(fileBlob);

    final anchorElement = html.AnchorElement(href: url);
    anchorElement.download = filename;
    anchorElement.click();

    await Future.delayed(const Duration(seconds: 1));
    html.Url.revokeObjectUrl(url);
    return 'Download successful';
  }
}

class MobileDownloadService implements DownloadService {
  @override
  Future<String?> download({required String url, String? filename, int? bytes}) async {
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
    switch (result.status) {
      case TaskStatus.complete:
        return 'Download successful';

      case TaskStatus.canceled:
        return 'Download was canceled';

      case TaskStatus.paused:
        return 'Download was paused';

      default:
        return 'Download not successful';
    }
  }
}
