import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tamadrop_riverpod/presentation/layout/layout_page.dart';
import 'package:tamadrop_riverpod/presentation/pages/home/home_route.dart';
import 'package:tamadrop_riverpod/presentation/pages/playlist/playlist_route.dart';

part 'router.g.dart';

/// navigatorにアクセスするためのグローバル変数
///
/// 特定のNavigatorウィジェットの状態にアクセスするために使用されます。
/// TODO enable to get id from path
final shellNavigatorKey = GlobalKey<NavigatorState>();

@TypedShellRoute<MyShellRoute>(
  routes: <TypedRoute<RouteData>>[
    TypedGoRoute<HomeRoute>(
      path: '/',
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<PlaylistRoute>(path: 'playlist'),
      ],
    ),
  ],
)
class MyShellRoute extends ShellRouteData {
  const MyShellRoute();

  static final $navigatorKey = shellNavigatorKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) =>
      LayoutPage(navigator);
}
