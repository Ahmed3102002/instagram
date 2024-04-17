import 'package:flutter/material.dart';

class CustomBasicPage extends StatelessWidget {
  const CustomBasicPage({super.key, required this.children, this.appBar});
  final List<Widget> children;
  final PreferredSizeWidget? appBar;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: appBar,
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: children,
        ),
      ),
    );
  }
}
