import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tamadrop_riverpod/application/usecase/playlist/playlist_interface.dart';
import 'package:tamadrop_riverpod/domain/entity/playlist/playlist.dart';
import 'package:tamadrop_riverpod/domain/interface/repository/playlist_repo_interface.dart';
import 'package:tamadrop_riverpod/infra/impl/repository/playlist_repo_impl.dart';
import 'package:tamadrop_riverpod/infra/service/sqlite/sqlite.dart';

part 'playlist.g.dart';

@riverpod
class PlaylistList extends _$PlaylistList implements PlaylistInterface {
  late final PlaylistRepoInterface repo;
  late final Database db;

  @override
  Future<List<Playlist>> build() async {
    state = AsyncValue.loading();
    db = ref.read(sqfliteProvider);
    repo = PlaylistRepoImpl(db: db);
    return await repo.getPlaylists();
  }

  @override
  Future<void> getPlaylists() async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await repo.getPlaylists();
    });
  }

  @override
  Future<void> addPlaylist(String name) async {
    state = AsyncValue.loading();
    await AsyncValue.guard(() async {
      await repo.addPlaylist(name);
    });
    await getPlaylists();
  }

  @override
  Future<void> updatePlaylist(String name, String id) async {
    state = AsyncValue.loading();
    await AsyncValue.guard(() async {
      await repo.updatePlaylist(name, id);
    });
    await getPlaylists();
  }

  @override
  Future<void> deletePlaylist(String id) async {
    state = AsyncValue.loading();
    await AsyncValue.guard(() async {
      await repo.deletePlaylist(id);
    });
    await getPlaylists();
  }

  @override
  Future<bool> checkIsDuplicate(String name) async {
    return await repo.checkIsDuplicate(name);
  }
}
