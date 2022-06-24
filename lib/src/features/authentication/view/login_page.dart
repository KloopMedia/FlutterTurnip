import 'package:flutter/material.dart';
import 'package:gigaturnip/src/features/authentication/authentication.dart';
import 'package:gigaturnip/extensions/buildcontext/loc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.loc.login)),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: LoginForm(),
      ),
    );
  }
}