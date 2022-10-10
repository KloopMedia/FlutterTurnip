import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MobileRichText extends StatefulWidget {
  final String htmlText;

  const MobileRichText({Key? key, required this.htmlText}) : super(key: key);

  @override
  State<MobileRichText> createState() => _MobileRichTextState();
}

class _MobileRichTextState extends State<MobileRichText> {
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
