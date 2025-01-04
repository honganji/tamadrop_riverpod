import 'package:flutter/material.dart';
import 'package:tamadrop_riverpod/config/router/router.dart';
import 'package:tamadrop_riverpod/presentation/pages/home/home_route.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Playlist Page'),
          ElevatedButton(
            onPressed: () {
              HomeRoute().go(context);
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
