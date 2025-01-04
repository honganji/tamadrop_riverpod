import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tamadrop_riverpod/presentation/pages/playlist/playlist_page.dart';

class PlaylistRoute extends GoRouteData {
  PlaylistRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => PlaylistPage();
}
