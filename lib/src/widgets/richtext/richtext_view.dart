import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';
import 'package:gigaturnip/src/widgets/richtext/mobile_richtext.dart'
    if (dart.library.html) 'package:gigaturnip/src/widgets/richtext/web_richtext.dart'
    as multiPlatform;

class RichTextView extends StatefulWidget {
  final String htmlText;
  final void Function()? onCloseCallback;

  const RichTextView({Key? key, required this.htmlText, required this.onCloseCallback})
      : super(key: key);

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
    final onClose = widget.onCloseCallback;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Webview'),
      ),
      body: Builder(builder: (context) {
        if (widget.htmlText.isEmpty) {
          return Center(child: Text(context.loc.empty_richtext, style: Theme.of(context).textTheme.headlineSmall));
        }
        return multiPlatform.RichText(htmlText: fullHtml);
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
              child: Text(context.loc.close, style: Theme.of(context).textTheme.headlineMedium),
            ),
          ),
        ),
      ),
    );
  }
}
