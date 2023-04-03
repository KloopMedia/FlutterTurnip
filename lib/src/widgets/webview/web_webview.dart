import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CustomWebView extends StatefulWidget {
  final String htmlText;

  const CustomWebView({Key? key, required this.htmlText}) : super(key: key);

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  final uniqueKey = UniqueKey().toString();

  @override
  void initState() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      uniqueKey,
          (int viewId) => IFrameElement()
        ..srcdoc = widget.htmlText
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: uniqueKey);
  }
}
