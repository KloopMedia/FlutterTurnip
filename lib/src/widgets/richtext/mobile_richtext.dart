import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RichText extends StatefulWidget {
  final String htmlText;

  const RichText({Key? key, required this.htmlText}) : super(key: key);

  @override
  State<RichText> createState() => _RichTextState();
}

class _RichTextState extends State<RichText> {
  @override
  void initState() {
    if (io.Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: 'about:blank',
      onWebViewCreated: (webViewController) {
        webViewController.loadHtmlString(widget.htmlText);
      },
    );
  }
}
