import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tamadrop_riverpod/config/router/router.dart';
import 'package:tamadrop_riverpod/presentation/pages/error/error_route.dart';
import 'package:tamadrop_riverpod/application/usecase/theme/theme.dart';

class App extends ConsumerWidget {
  App({super.key});

  final router = GoRouter(
    routes: $appRoutes,
    initialLocation: '/',
    errorBuilder: (context, state) {
      return ErrorRoute(state.error.toString()).build(context, state);
    },
  );
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp.router(
      theme: theme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
