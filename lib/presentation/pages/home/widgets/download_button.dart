import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tamadrop_riverpod/presentation/pages/home/widgets/download_sheet.dart';

class DownloadButton extends ConsumerWidget {
  const DownloadButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      bottom: 24.0,
      left: 0,
      right: 0,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return DownloadSheet();
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
          child: const Icon(Icons.download),
        ),
      ),
    );
  }
}
