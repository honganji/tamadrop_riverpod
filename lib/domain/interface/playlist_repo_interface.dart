import 'package:tamadrop_riverpod/domain/entity/playlist/playlist.dart';

abstract interface class PlaylistRepoInterface {
  Future<List<Playlist>> getPlaylists();
  Future<void> addPlaylist(String name);
  Future<void> updatePlaylist(String name, String id);
  Future<void> deletePlaylist(String id);
  Future<bool> checkIsDuplicate(String name);
}
