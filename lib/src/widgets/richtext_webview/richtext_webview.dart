import 'dart:convert' show utf8, base64;
import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class RichTextWebview extends StatefulWidget {
  final String initialUrl;
  final String text;

  const RichTextWebview({Key? key, required this.text, required this.initialUrl}) : super(key: key);

  @override
  State<RichTextWebview> createState() => _RichTextWebviewState();
}

class _RichTextWebviewState extends State<RichTextWebview> {
  late WebViewPlusController _controller;
  double _height = 1;

  Future<void> runJS(String text) async {
    await _controller.webViewController.runJavascript("""
      (function() { window.dispatchEvent(new CustomEvent('flutter_rich_text_event', {detail: "$text"})); })();
    """);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: WebViewPlus(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.initialUrl,
        onWebViewCreated: (webViewController) {
          setState(() {
            _controller = webViewController;
          });
        },
        onPageFinished: (str) async {
          Future.delayed(const Duration(milliseconds: 10), () async {
            final encodedText = base64.encode(utf8.encode(widget.text));
            await runJS(encodedText);
            _controller.getHeight().then((double height) {
              setState(() {
                _height = height + 80;
              });
            });
          });
        },
      ),
    );
  }
}
