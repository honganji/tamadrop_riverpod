import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tamadrop_riverpod/presentation/pages/home/home_page.dart';

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => HomePage();
}
