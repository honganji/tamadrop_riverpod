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
    return await repo.getVideos();
  }

  @override
  Future<void> getVideos() async {
    print("getVideos");
  }

  @override
  Future<void> addVideo(String name) {
    // TODO: implement addVideo
    throw UnimplementedError();
  }

  @override
  Future<void> updateVideo(String name, String id) {
    // TODO: implement updateVideo
    throw UnimplementedError();
  }

  @override
  Future<void> deleteVideo(String id) {
    // TODO: implement deleteVideo
    throw UnimplementedError();
  }

  @override
  Future<void> checkIsDuplicate(String name) {
    // TODO: implement checkIsDuplicate
    throw UnimplementedError();
  }

  @override
  Future<void> downloadVideo(String url) {
    final DownloadApiInterface api = DownloadApiImpl(url);
    return api.downloadVideo();
  }

  @override
  Future<void> getVideosByCategory(String pid) async {
    print(pid + "getVideosByCategory");
  }
}
