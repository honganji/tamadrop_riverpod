// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $myShellRoute,
    ];

RouteBase get $myShellRoute => ShellRouteData.$route(
      navigatorKey: MyShellRoute.$navigatorKey,
      factory: $MyShellRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/',
          factory: $HomeRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'playlist',
              factory: $PlaylistRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $MyShellRouteExtension on MyShellRoute {
  static MyShellRoute _fromState(GoRouterState state) => const MyShellRoute();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $PlaylistRouteExtension on PlaylistRoute {
  static PlaylistRoute _fromState(GoRouterState state) => PlaylistRoute();

  String get location => GoRouteData.$location(
        '/playlist',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
