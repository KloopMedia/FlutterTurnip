import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';

class WebView extends StatefulWidget {
  final String htmlText;
  final bool allowOpenPrevious;
  final void Function()? onSubmitCallback;
  final void Function()? onCloseCallback;
  final void Function()? onOpenPreviousTask;

  const WebView({
    Key? key,
    String? html = "",
    this.onSubmitCallback,
    this.onCloseCallback,
    this.onOpenPreviousTask,
    this.allowOpenPrevious = false,
  })  : htmlText = html as String,
        super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      supportZoom: false,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);

  @override
  Widget build(BuildContext context) {
    final onClose = widget.onCloseCallback;
    final onSubmit = widget.onSubmitCallback;
    final onPrevious = widget.onOpenPreviousTask;
    final theme = Theme.of(context).colorScheme;

    final width = context.isSmall || context.isMedium ? '100%' : '70%';
    final backgroundColor = theme.isLight ? 'rgba(0, 0, 0, 1)' : 'rgba(196, 199, 199, 1)';

    final fullHtml = '''
    <html>
      <style>  
      #container {
        margin: auto;
        width: $width;
        border-style: groove;
      }
      #spacer {
        padding: 8px 16px;
      }
      p, h1, h2, h3, h4, h5, li {
        color: $backgroundColor !important;
      }
      </style>  
      <head>  
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="theme-color" content="#000000" />
      </head>
      <body>
        <div id="container">
          <div id="spacer">
            ${widget.htmlText}
          </div>
        </div>
      </body>
    </html>
    ''';

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onClose != null) {
              onClose();
            }
          },
        ),
      ),
      body: Builder(builder: (context) {
        if (widget.htmlText.isEmpty) {
          return Center(
            child: Text(
              context.loc.empty_richtext,
            ),
          );
        }
        return InAppWebView(
          key: webViewKey,
          initialSettings: settings,
          initialData: InAppWebViewInitialData(data: fullHtml),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
        );
      }),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: context.isSmall || context.isMedium
                ? 0
                : MediaQuery.of(context).size.width / 5,
          ),
          padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.allowOpenPrevious)
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (onPrevious != null) {
                          onPrevious();
                        }
                      },
                      child: Text(context.loc.go_back_to_previous_task),
                    ),
                  ),
                ),
              if (widget.allowOpenPrevious) const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: theme.primary,
                      foregroundColor: theme.isLight ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (onSubmit != null) {
                        onSubmit();
                      }
                    },
                    child: Text(context.loc.close),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
