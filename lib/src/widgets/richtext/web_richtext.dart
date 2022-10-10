import 'dart:convert';
import "package:universal_html/html.dart";
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class WebRichText extends StatefulWidget {
  final String htmlText;

  const WebRichText({Key? key, required this.htmlText}) : super(key: key);

  @override
  State<WebRichText> createState() => _WebRichTextState();
}

class _WebRichTextState extends State<WebRichText> {
  final uniqueKey = UniqueKey().toString();

  @override
  void initState() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      uniqueKey,
      (int viewId) => IFrameElement()
        ..src = Uri.dataFromString(
          widget.htmlText,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString()
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
