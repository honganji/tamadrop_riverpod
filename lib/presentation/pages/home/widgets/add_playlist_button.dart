import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamadrop_riverpod/application/usecase/playlist/playlist.dart';

class AddPlaylistButton extends ConsumerWidget {
  const AddPlaylistButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(playlistListProvider.notifier);
    return ElevatedButton(
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
    );
  }
}
