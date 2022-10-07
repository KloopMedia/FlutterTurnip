import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RichTextWebView extends StatefulWidget {
  final String htmlText;

  const RichTextWebView({Key? key, required this.htmlText}) : super(key: key);

  @override
  State<RichTextWebView> createState() => _RichTextWebViewState();
}

class _RichTextWebViewState extends State<RichTextWebView> {
  late final String fullHtml;

  @override
  void initState() {
    fullHtml = '''
    <html>
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="theme-color" content="#000000" />
      </head>
      <body>
        ${widget.htmlText}
      </body>
    </html>
    ''';

    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Webview'),
      ),
      body: Builder(builder: (context) {
        if (widget.htmlText.isEmpty) {
          return const Center(
            child: Text('Rich text is empty'),
          );
        }
        return WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: 'about:blank',
          onWebViewCreated: (webViewController) {
            webViewController.loadHtmlString(fullHtml);
          },
        );
      }),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Закрыть'),
          ),
        ),
      ),
    );
  }
}
