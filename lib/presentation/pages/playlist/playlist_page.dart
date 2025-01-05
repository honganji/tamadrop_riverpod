import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tamadrop_riverpod/application/usecase/video/video_list.dart';
import 'package:tamadrop_riverpod/presentation/pages/home/home_route.dart';
import 'package:tamadrop_riverpod/presentation/pages/playlist/widgets/video_box.dart';

class PlaylistPage extends HookConsumerWidget {
  const PlaylistPage(this.id, {super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoList = ref.watch(videoListProvider);
    final notifier = ref.read(videoListProvider.notifier);
    useEffect(() {
      notifier.getVideosByCategory(id);
      return null;
    }, []);
    return videoList.when(
      data: (data) {
        return Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final video = data[index];
                    return VideoBox(index, video);
                  },
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stack) => Center(
        child: Column(
          children: [
            Text('Error: $error'),
            ElevatedButton(
              onPressed: () {
                HomeRoute().go(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
