import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tamadrop_riverpod/presentation/pages/error/error_page.dart';

class ErrorRoute extends GoRouteData {
  const ErrorRoute(this.message);
  final String message;

  @override
  Widget build(BuildContext context, GoRouterState state) => ErrorPage(message);
}
