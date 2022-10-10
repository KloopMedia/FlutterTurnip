import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip/src/widgets/richtext/mobile_richtext.dart';
import 'package:gigaturnip/src/widgets/richtext/web_richtext.dart';

class RichTextView extends StatefulWidget {
  final String htmlText;

  const RichTextView({Key? key, required this.htmlText}) : super(key: key);

  @override
  State<RichTextView> createState() => _RichTextViewState();
}

class _RichTextViewState extends State<RichTextView> {
  late final String fullHtml;
  final isWeb = kIsWeb;

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
          return const Center(child: Text('Rich text is empty'));
        }
        if (isWeb) {
          return WebRichText(htmlText: fullHtml);
        } else {
          return MobileRichText(htmlText: fullHtml);
        }
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
