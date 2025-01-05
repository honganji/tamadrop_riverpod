import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamadrop_riverpod/application/usecase/playlist/playlist.dart';
import 'package:tamadrop_riverpod/constants/size.dart';
import 'package:tamadrop_riverpod/presentation/pages/home/widgets/add_playlist_button.dart';
import 'package:tamadrop_riverpod/presentation/pages/home/widgets/download_button.dart';
import 'package:tamadrop_riverpod/presentation/pages/home/widgets/playlist_box.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlist = ref.watch(playlistListProvider);
    return Stack(
      children: [
        playlist.when(
          data: (data) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return PlaylistBox(data[index]);
                  },
                ),
                AddPlaylistButton(),
                const SizedBox(
                  height: BOTTOM_SAFE_AREA,
                ),
              ],
            ),
          ),
          error: (error, stack) => Center(
            child: Text('Error: $error'),
          ),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        ),
        DownloadButton(),
      ],
    );
  }
}
