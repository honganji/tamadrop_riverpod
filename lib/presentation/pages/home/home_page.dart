import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamadrop_riverpod/application/usecase/playlist/playlist.dart';
import 'package:tamadrop_riverpod/config/router/router.dart';
import 'package:tamadrop_riverpod/constants/size.dart';
import 'package:tamadrop_riverpod/presentation/pages/home/widgets/playlist_box.dart';
import 'package:tamadrop_riverpod/presentation/pages/playlist/playlist_route.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlist = ref.watch(playlistListProvider);
    final notifier = ref.read(playlistListProvider.notifier);
    return playlist.when(
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
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    final TextEditingController textController =
                        TextEditingController();
                    return AlertDialog(
                      title: const Text('Add Playlist'),
                      content: TextField(
                        controller: textController,
                        decoration: const InputDecoration(
                          labelText: 'Playlist Name',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final String name = textController.text;
                            final bool isDuplicate =
                                await notifier.checkIsDuplicate(name);
                            if (isDuplicate) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Playlist already exists'),
                                ),
                              );
                            } else if (name.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Input a name'),
                                ),
                              );
                            } else {
                              notifier.addPlaylist(name);
                            }
                            Navigator.of(context).pop();
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
                shadowColor: Theme.of(context).colorScheme.inversePrimary,
                elevation: 5,
              ),
              child: const Text('Add Playlist'),
            ),
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
    );
  }
}
