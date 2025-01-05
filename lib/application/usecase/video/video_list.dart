import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tamadrop_riverpod/application/usecase/video/video_interface.dart';
import 'package:tamadrop_riverpod/domain/entity/video/video.dart';
import 'package:tamadrop_riverpod/domain/interface/api/download_api_interface.dart';
import 'package:tamadrop_riverpod/domain/interface/repository/video_repo_interface.dart';
import 'package:tamadrop_riverpod/infra/impl/api/download_api_impl.dart';
import 'package:tamadrop_riverpod/infra/impl/repository/video_repo_impl.dart';
import 'package:tamadrop_riverpod/infra/service/sqlite/sqlite.dart';

part 'video_list.g.dart';

@riverpod
class VideoList extends _$VideoList implements VideoInterface {
  late final VideoRepoInterface repo;
  late final Database db;

  @override
  Future<List<Video>> build() async {
    state = AsyncValue.loading();
    db = ref.read(sqfliteProvider);
    repo = VideoRepoImpl(db: db);
    try {
      return await repo.getVideos();
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
      return [];
    }
  }

  @override
  Future<void> getVideos() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await repo.getVideos();
    });
  }

  @override
  Future<void> getVideosByCategory(String pid) async {
    // state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await repo.getVideosByCategory(pid);
    });
  }

  @override
  Future<void> addVideo(String url, String? pid) async {
    state = AsyncValue.loading();
    final DownloadApiInterface api = DownloadApiImpl(url);
    final Video video = await api.downloadVideo();
    await AsyncValue.guard(() async {
      try {
        return await repo.addVideo(video, pid);
      } catch (e) {
        print(e.toString());
      }
    });
  }

  @override
  Future<void> deleteVideo(String id) async {
    state = AsyncValue.loading();
    await AsyncValue.guard(() async {
      await repo.deleteVideo(id);
      await getVideos();
    });
  }

  @override
  Future<bool> checkIsDuplicate(String name) async {
    try {
      return await repo.checkIsDuplicate(name);
    } catch (e) {
      print(e.toString());
      return true;
    }
  }

  @override
  Future<void> downloadVideo(String url) {
    final DownloadApiInterface api = DownloadApiImpl(url);
    return api.downloadVideo();
  }
}
