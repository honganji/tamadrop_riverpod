import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:tamadrop_riverpod/application/usecase/video/video_list.dart';
import 'package:tamadrop_riverpod/domain/entity/video/video.dart';
import 'package:tamadrop_riverpod/presentation/pages/player/player_page.dart';

class VideoBox extends ConsumerWidget {
  final Video video;
  final int index;
  const VideoBox(this.index, this.video, {super.key});

  String formatDuration(int seconds) {
    final int hours = seconds ~/ 3600;
    final int minutes = (seconds % 3600) ~/ 60;
    final int remainingSeconds = seconds % 60;

    final String hoursStr = '${hours.toString().padLeft(2, '0')}:';
    final String minutesStr = '${minutes.toString().padLeft(2, '0')}:';
    final String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$hoursStr$minutesStr$secondsStr';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateFormat formatter = DateFormat('d/M/yyyy HH:mm:ss');
    final String formattedDate = formatter.format(video.createdAt);
    final notifier = ref.read(videoListProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(2),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      width: double.infinity,
      height: 72,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PlayerPage(video)));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.asset(video.thumbnailFilePath),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          video.title.trimLeft(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        )),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "${video.volume.toString()}MB",
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          formatDuration(video.length),
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Do you wanna delete this video?'),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              notifier.deleteVideo(video.id);
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(
              Icons.delete,
              size: 32,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
