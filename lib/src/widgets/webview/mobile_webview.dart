import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {
  final String htmlText;

  const CustomWebView({Key? key, required this.htmlText}) : super(key: key);

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            final domain = Uri.parse(request.url).authority;
            if (domain == "kloopmedia.github.io") {
              final url = request.url.split('#').last;
              context.push(url);
              return NavigationDecision.prevent;
            } else {
              final url = Uri.parse(request.url);
              await launchUrl(url, mode: LaunchMode.externalApplication);
              return NavigationDecision.prevent;
            }
          },
        ),
      )
      ..loadHtmlString(widget.htmlText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
