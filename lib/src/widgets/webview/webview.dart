import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
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
  @override
  Widget build(BuildContext context) {
    final onClose = widget.onCloseCallback;

    final width = context.isSmall || context.isMedium ? '100%' : '70%';

    final fullHtml = '''
    <html>
      <style>  
      div {  
        padding: 15px 20px;  
      }  
      #container {
        margin: auto;
        width: $width;
      }
      </style>  
      <head>  
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="theme-color" content="#000000" />
      </head>
      <body>
        <div id="container">
          ${widget.htmlText}
        </div>
      </body>
    </html>
    ''';

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
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: context.isSmall || context.isMedium
                ? 0
                : MediaQuery.of(context).size.width / 5,
          ),
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
