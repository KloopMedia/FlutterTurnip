import 'package:flutter/material.dart';

class ScaffoldAppbar extends StatelessWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget child;

  const ScaffoldAppbar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.drawer,
    this.floatingActionButton,
    this.bottomNavigationBar,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        title: title,
        centerTitle: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFEFBD2), Color(0xFFFECFB5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        titleSpacing: 0,
        leadingWidth: 64,
        leading: leading,
        actions: [
          ...?actions,
          SizedBox(width: 12),
        ],
      ),
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
        padding: EdgeInsets.only(top: 9),
        decoration: BoxDecoration(
          color: Color(0xFFFECFB5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFFAFDFD),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
