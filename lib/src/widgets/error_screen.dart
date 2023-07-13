import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final dynamic detailsException;

  const ErrorScreen({Key? key, required this.detailsException}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: kReleaseMode
            ? const Center(child: Text('Sorry for inconvenience',style: TextStyle(fontSize: 24.0)))
            : SingleChildScrollView(child: Text('Exception Details:\n$detailsException')),
        )
    );

  }
}
