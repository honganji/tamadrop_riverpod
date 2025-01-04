import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tamadrop_riverpod/config/router/router.dart';
import 'package:tamadrop_riverpod/presentation/pages/error/error_route.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: $appRoutes,
      initialLocation: '/',
      errorBuilder: (context, state) {
        return ErrorRoute(state.error.toString()).build(context, state);
      },
    );
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
