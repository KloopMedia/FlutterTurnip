import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewForGames extends StatefulWidget {
  final String url;
  final void Function()? onCloseCallback;

  const WebViewForGames({
    super.key,
    required this.url,
    required this.onCloseCallback,
  });

  @override
  State<WebViewForGames> createState() => _WebViewForGamesState();
}

class _WebViewForGamesState extends State<WebViewForGames> {
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    supportZoom: false,
    iframeAllowFullscreen: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (widget.onCloseCallback != null) {
              widget.onCloseCallback!();
            }
          },
        ),
      ),
      body: InAppWebView(
        initialSettings: settings,
        initialUrlRequest: URLRequest(url: WebUri(widget.url)),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
      ),
    );
  }
}
