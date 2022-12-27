import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/authentication/authentication.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

class LoginPage extends StatelessWidget {
  final bool simpleViewMode;

  const LoginPage({Key? key, this.simpleViewMode = false}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Кирүү үчүн "Google аркылуу катталуу" баскычын басыңыз')),//Text(context.loc.login)),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: LoginForm(simpleViewMode: simpleViewMode),
      ),
    );
  }
}