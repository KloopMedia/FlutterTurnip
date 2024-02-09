import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/theme/index.dart';
import 'package:universal_html/parsing.dart';
import "package:universal_html/html.dart" as html;

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
    iframeAllowFullscreen: true,
  );

  @override
  Widget build(BuildContext context) {
    final onClose = widget.onCloseCallback;
    final onSubmit = widget.onSubmitCallback;
    final onPrevious = widget.onOpenPreviousTask;
    final theme = Theme.of(context).colorScheme;

    final width = context.isSmall || context.isMedium ? '100%' : '70%';
    final backgroundColor = theme.isLight ? 'rgba(0, 0, 0, 1)' : 'rgba(196, 199, 199, 1)';

    final smallAudioPlayer = """
          audio {
            width: 110px;
            height: 40px;
            animation: audioWidth 0.1s forwards;
          }

          auto::-webkit-media-controls-panel {
            justify-content: center;
          }
          
          audio::-webkit-media-controls-volume-slider {
            display: none !important;
            min-width: 0;
          }
          
          audio::-webkit-media-controls-timeline-container {
            display: none !important;
            min-width: 0;
          }
          
          audio::-webkit-media-controls-time-remaining-display {
            display: none !important;
            min-width: 0;
          }
          
          audio::-webkit-media-controls-timeline {
            display: none !important;
            min-width: 0;
          }
          
          @keyframes audioWidth {
            from {
              width: 110px;
            }
            to {
              width: 84px;
            }
          }
    """;

    final fullHtml = '''
    <html>
      <head>  
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        
        <style>
          body {
            background-color: white;
            color: black;
          }
          
          .dark-mode {
            background-color: black;
            color: white;
          }
          
          #container {
            margin: auto;
            width: $width;
            border-style: groove;
          }
          
          #spacer {
            padding: 8px 16px;
          }
          
          ${context.isSmall ? smallAudioPlayer : ""}  
        </style>
      </head>
      <body>
        <div id="container">
          <div id="spacer">
            ${widget.htmlText}
          </div>
        </div>
        <script>
          ${theme.isLight ? "" : 'document.body.classList.toggle("dark-mode");'}
        </script>
      </body>
    </html>
    ''';

    String _calculateColorFromBackgroundColor(Color color) {
      double luma = ((0.299 * color.red) + (0.587 * color.green) + (0.114 * color.blue)) / 255;
      return luma > 0.5 ? "black" : "white";
    }

    Color? _parseColorFromString(String rgb) {
      final start = rgb.indexOf('(');
      final end = rgb.indexOf(')');
      if (start >= 0 && end >= 0) {
        final colorList = rgb.substring(start + 1, end).split(',');
        final parsedColor = colorList.map((e) => int.parse(e)).toList();
        return Color.fromRGBO(parsedColor[0], parsedColor[1], parsedColor[2], 1);
      }
      return null;
    }

    String calculateFontColor(html.Element element) {
      final closestParentWithBackgroundColor = element.closest("[style*='background-color']");
      final backgroundColor = closestParentWithBackgroundColor?.style.backgroundColor ?? "";
      final parsedColor = _parseColorFromString(backgroundColor);
      if (parsedColor != null) {
        return _calculateColorFromBackgroundColor(parsedColor);
      }
      return "white";
    }

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
        final parsedData = parseHtmlDocument(fullHtml);

        parsedData.querySelectorAll("span[style*='#000000']").forEach((el) {
          el.style.color = calculateFontColor(el);
        });

        parsedData.querySelectorAll("iframe").forEach((element) {
          element.setAttribute("style", "width: 100%; aspect-ratio: 16 / 9;");
        });

        // parsedData.querySelectorAll("audio").forEach((element) {
        //   final audioButton = html.Element.tag('input')
        //     ..attributes.addAll(
        //       {
        //         "type": "button",
        //         "value": "sound",
        //         "onclick": """
        //       var music = new Audio('${element.attributes["src"]}');
        //       music.play();
        //       """
        //       },
        //     );
        //   element.replaceWith(audioButton);
        // });

        final dataString = parsedData.documentElement?.innerHtml ?? "";

        return InAppWebView(
          key: webViewKey,
          initialSettings: settings,
          initialData: InAppWebViewInitialData(data: dataString),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
        );
      }),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal:
                context.isSmall || context.isMedium ? 0 : MediaQuery.of(context).size.width / 5,
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
