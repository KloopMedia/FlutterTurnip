import 'dart:io';

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
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: kDebugMode,
    mediaPlaybackRequiresUserGesture: true,
    allowsInlineMediaPlayback: true,
    supportZoom: true,
    iframeAllowFullscreen: true,
    supportMultipleWindows: true,
    javaScriptCanOpenWindowsAutomatically: true,
  );

  late String _data;

  @override
  void didChangeDependencies() {
    final theme = Theme.of(context).colorScheme;
    final width = context.isSmall || context.isMedium ? '100%' : '70%';

    final fullHtml = '''
    <html>
      <head>  
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        
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
          
          .player-button {
            background-color: #04AA6D;
            border: none;
            color: white;
            padding: 20px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size:24px;
            margin: 4px 4px;
            cursor: pointer;
            border-radius: 10px;
          }
          
          .pause-icon {
            background: red;
          }
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
        <script>
          ${r"""$(document).ready(function(){
            $(document).on('click' , '.player-button' , function(){
              var This_Button = $(this),
                  This_audio = $(this).parent().find('audio')[0];
           
              This_Button.toggleClass('fa-volume-high fa-stop pause-icon');
              if (This_audio.paused) 
              {
                This_audio.play();
              } 
              else {
              This_audio.pause();
              This_audio.currentTime = 0;
              }
            })
          });
      
          function on_playing_ended(el){
            $(el).parent().find('.player-button').toggleClass('fa-volume-high fa-stop pause-icon');
          }"""}
      </script>
      </body>
    </html>
    ''';

    final parsedData = parseHtmlDocument(fullHtml);

    parsedData.querySelectorAll("span[style*='#000000']").forEach((el) {
      if (theme.isDark) {
        el.style.color = calculateFontColor(el);
      }
    });

    final displaySize = MediaQuery.of(context).size;
    var iframeWidth = "100%";
    var iframeHeight = "${displaySize.height * 9 / 16}px";
    parsedData.querySelectorAll("iframe").forEach((element) {
      element.setAttribute(
          "style", "width: $iframeWidth; height: $iframeHeight; aspect-ratio: 16 / 9;");
    });

    parsedData.querySelectorAll("audio").forEach((element) {
      if (!(element.innerHtml?.trim().contains(RegExp('/fullsize/')) ?? false)) {
        element.replaceWith(html.Element.html("""
      <div class="">
        <audio class="player" src="${element.attributes["src"]}" onended="on_playing_ended(this);"></audio>
        <div class="player-button fa-solid fa-volume-high"></div>
      </div>
      """, treeSanitizer: html.NodeTreeSanitizer.trusted));
      }
    });

    parsedData.querySelectorAll("img").forEach((element) {
      final link = html.Element.a();
      link.setAttribute("href", element.attributes['src'] ?? "");

      final imageWidth = double.tryParse(element.attributes['width'] ?? "");
      if (imageWidth != null && imageWidth > displaySize.width) {
        element.setAttribute('width', '100%');
        element.setAttribute('height', 'auto');
      }

      link.appendHtml(element.outerHtml!, treeSanitizer: html.NodeTreeSanitizer.trusted);
      element.replaceWith(link);
    });

    _data = parsedData.documentElement?.innerHtml ?? "";

    super.didChangeDependencies();
  }

  String _calculateColorFromBackgroundColor(Color color) {
    double luma = ((0.299 * color.red) + (0.587 * color.green) + (0.114 * color.blue)) / 255;
    return luma > 0.5 ? "black" : "white";
  }

  Color? _parseColorFromString(String color) {
    final value = color.replaceFirst("#", "aa");
    final parsedValue = int.tryParse(value, radix: 16);
    if (parsedValue != null) {
      return Color(parsedValue);
    }

    final start = color.indexOf('(');
    final end = color.indexOf(')');
    if (start >= 0 && end >= 0) {
      final colorList = color.substring(start + 1, end).split(',');
      final parsedColor = colorList.map((e) => int.parse(e)).toList();
      return Color.fromRGBO(parsedColor[0], parsedColor[1], parsedColor[2], 1);
    }
    return null;
  }

  html.Element? _closest(html.Element element, String attribute, String selector) {
    final parent = element.parent;
    if (parent == null) {
      return null;
    }

    final parentStyle = parent.getAttribute(attribute);
    if (parentStyle?.contains(selector) ?? false) {
      return parent;
    } else {
      return _closest(parent, attribute, selector);
    }
  }

  String calculateFontColor(html.Element element) {
    final closestParentWithBackgroundColor = _closest(element, 'style', 'background-color');
    final backgroundColor = closestParentWithBackgroundColor?.style.backgroundColor ?? "";
    final parsedColor = _parseColorFromString(backgroundColor);
    if (parsedColor != null) {
      return _calculateColorFromBackgroundColor(parsedColor);
    }
    return "white";
  }

  @override
  Widget build(BuildContext context) {
    final onSubmit = widget.onSubmitCallback;
    final onPrevious = widget.onOpenPreviousTask;
    final onClose = widget.onCloseCallback;

    final theme = Theme.of(context).colorScheme;

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
          initialSettings: settings,
          initialData: InAppWebViewInitialData(data: _data),
          onCreateWindow: (controller, action) async {
            if (Platform.isAndroid) {
              await InAppBrowser.openWithSystemBrowser(url: action.request.url!);
            }
          },
          onWebViewCreated: (controller) {
            setState(() {
              webViewController = controller;
            });
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
