import 'dart:convert';
import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class RichText extends StatefulWidget {
  final String htmlText;

  const RichText({Key? key, required this.htmlText}) : super(key: key);

  @override
  State<RichText> createState() => _RichTextState();
}

class _RichTextState extends State<RichText> {
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
