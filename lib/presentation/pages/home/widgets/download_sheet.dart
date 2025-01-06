import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamadrop_riverpod/application/usecase/playlist/playlist.dart';
import 'package:tamadrop_riverpod/application/usecase/progress/progress.dart';
import 'package:tamadrop_riverpod/application/usecase/video/video_list.dart';
import 'package:tamadrop_riverpod/presentation/funcs/my_snack_bar.dart';
import 'package:tamadrop_riverpod/presentation/pages/home/widgets/my_text_field.dart';

class DownloadSheet extends StatefulWidget {
  const DownloadSheet({super.key});

  @override
  State<DownloadSheet> createState() => _DownloadSheetState();
}

class _DownloadSheetState extends State<DownloadSheet> {
  final textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  int? selectedOption;
  String? playlistId;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final progress = ref.watch(progressProvider);
        final video = ref.watch(videoListProvider);
        ref.listen<double>(progressProvider, (previous, next) {
          if (next == 0.0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Download finished!')),
            );
          }
        });
        return video.when(
          data: (data) {
            return child!;
          },
          error: (error, stack) {
            return Center(
              child: Text('Error: $error'),
            );
          },
          loading: () {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Progress: ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("${(progress).toStringAsFixed(1)} %")
                ],
              ),
            );
          },
        );
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: MyTextField(
                controller: textController,
                hintText: "https://www.youtube.com/watch?v=...",
                labelText: "Youtube URL",
                focusNode: focusNode,
              ),
            ),
            const SizedBox(height: 20),
            Consumer(builder: (context, ref, child) {
              final playlists = ref.watch(playlistListProvider);
              return playlists.when(
                data: (data) => DropdownButton<int>(
                  value: selectedOption,
                  hint: const Text('playlist'),
                  items: data
                      .where((playlist) => playlist.name != "all")
                      .map((playlist) {
                    return DropdownMenuItem<int>(
                      value: data.indexOf(playlist),
                      child: Text(playlist.name),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    playlistId = data[newValue!].id;
                    setState(() {
                      selectedOption = newValue;
                    });
                  },
                ),
                error: (error, stack) => Center(
                  child: Text('Error: $error'),
                ),
                loading: () => const CircularProgressIndicator(),
              );
            }),
            const SizedBox(height: 20),
            Consumer(builder: (context, ref, child) {
              final notifier = ref.watch(videoListProvider.notifier);
              return ElevatedButton(
                onPressed: () async {
                  if (textController.text.isEmpty) {
                    mySnackBar(context, "Input a URL");
                    return;
                  }
                  final bool isDuplicate =
                      await notifier.checkIsDuplicate(textController.text);
                  if (isDuplicate) {
                    mySnackBar(context, "This video is already in the list");
                    return;
                  }
                  await notifier.addVideo(textController.text, playlistId);
                  textController.clear();
                  setState(() {
                    selectedOption = null;
                  });
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  ),
                  shadowColor: Theme.of(context).colorScheme.inversePrimary,
                  elevation: 5,
                ),
                child: const Text("download"),
              );
            }),
          ],
        ),
      ),
    );
  }
}
