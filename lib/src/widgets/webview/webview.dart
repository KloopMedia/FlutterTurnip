import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'mobile_webview.dart' if (dart.library.html) 'web_webview.dart' as multi_platform;

class WebView extends StatefulWidget {
  final String htmlText;
  final void Function()? onCloseCallback;

  const WebView({Key? key, String? html = "", this.onCloseCallback})
      : htmlText = html as String,
        super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final String fullHtml;

  @override
  void initState() {
    fullHtml = '''
    <html>
      <style>  
      div {  
        padding: 10px 20px;  
      }  
      </style>  
      <head>  
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="theme-color" content="#000000" />
      </head>
      <body>
        <div>
          ${widget.htmlText}
        </div>
      </body>
    </html>
    ''';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final onClose = widget.onCloseCallback;

    return Scaffold(
      appBar: AppBar(),
      body: Builder(builder: (context) {
        if (widget.htmlText.isEmpty) {
          return Center(
            child: Text(
              context.loc.empty_richtext,
            ),
          );
        }
        return multi_platform.CustomWebView(htmlText: fullHtml);
      }),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onClose != null) {
                onClose();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(context.loc.close),
            ),
          ),
        ),
      ),
    );
  }
}
