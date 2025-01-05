import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamadrop_riverpod/application/usecase/theme/theme.dart';
import 'package:tamadrop_riverpod/presentation/theme/dark_theme.dart';

class LayoutPage extends ConsumerWidget {
  const LayoutPage(this.child, {super.key});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeNotifier = ref.watch(themeProvider.notifier);
    final theme = ref.watch(themeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tama Drop'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSwitch(
              value: theme == darkTheme,
              onChanged: (value) {
                themeNotifier.toggleTheme();
              },
            ),
          ),
        ],
      ),
      body: child,
    );
  }
}
