import 'package:flutter/material.dart';
import 'package:tamadrop_riverpod/config/router/router.dart';
import 'package:tamadrop_riverpod/presentation/pages/playlist/playlist_route.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Home Page'),
          ElevatedButton(
            onPressed: () {
              PlaylistRoute().go(context);
            },
            child: const Text('Go to Playlist'),
          ),
        ],
      ),
    );
  }
}
