import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tamadrop_riverpod/application/usecase/playlist/playlist.dart';
import 'package:tamadrop_riverpod/domain/entity/playlist/playlist.dart';
import 'package:tamadrop_riverpod/presentation/pages/home/widgets/confirmation_alert.dart';

class EditAlert extends HookConsumerWidget {
  const EditAlert(this.playlist, {super.key});
  final Playlist playlist;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(playlistListProvider.notifier);
    final textController = useTextEditingController(text: playlist.name);
    return AlertDialog(
      title: const Text('Modify Playlist Name'),
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
        TextButton(
          onPressed: () async {
            final String name = textController.text;
            final bool isDuplicate = await notifier.checkIsDuplicate(name);
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
              notifier.updatePlaylist(name, playlist.id);
            }
            Navigator.of(context).pop();
          },
          child: const Text('Update'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    ConfirmationAlert(playlist.id));
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
