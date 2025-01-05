import 'package:flutter/material.dart';
import 'package:tamadrop_riverpod/domain/entity/playlist/playlist.dart';
import 'package:tamadrop_riverpod/presentation/pages/home/widgets/edit_alert.dart';

class PlaylistBox extends StatelessWidget {
  final Playlist playlist;
  const PlaylistBox(this.playlist, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Playlist: ${playlist.name}'),
          ),
        );
      },
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context)
                  .colorScheme
                  .inversePrimary, // Specify the border color
              width: 2, // Specify the border width
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                playlist.name,
                style: const TextStyle(fontSize: 20),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final TextEditingController textController =
                          TextEditingController();
                      textController.text = playlist.name;
                      return EditAlert(playlist);
                    },
                  );
                },
                child: Icon(
                  Icons.edit_note_sharp,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  // final videoPlayerCubit = context.read<VideoPlayerCubit>();
                  // await videoPlayerCubit.getCategorizedVideo(playlist.pid);
                  // if (videoPlayerCubit.videoList.isNotEmpty) {
                  //   playNotifier.value = true;
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //       content: Text('No video in the playlist'),
                  //     ),
                  //   );
                  // }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No video in the playlist'),
                    ),
                  );
                },
                child: Icon(
                  Icons.play_circle,
                  size: 32,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
