import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamadrop_riverpod/application/usecase/playlist/playlist.dart';

class ConfirmationAlert extends ConsumerWidget {
  const ConfirmationAlert(this.id, {super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(playlistListProvider.notifier);
    return AlertDialog(
      title: Text('確認'),
      content: Text('本当に削除してもよろしいですか？'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // 確認ダイアログを閉じる
          },
          child: Text('いいえ'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop(); // 確認ダイアログを閉じる
            await notifier.deletePlaylist(id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('削除しました')),
            );
          },
          child: Text('はい'),
        ),
      ],
    );
  }
}
