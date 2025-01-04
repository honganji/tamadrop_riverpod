import 'package:flutter/material.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage(this.child, {super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tama Drop'),
      ),
      body: child,
    );
  }
}
