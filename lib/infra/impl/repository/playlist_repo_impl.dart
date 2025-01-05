import 'package:sqflite/sqflite.dart';
import 'package:tamadrop_riverpod/domain/entity/playlist/playlist.dart';
import 'package:tamadrop_riverpod/domain/interface/repository/playlist_repo_interface.dart';
import 'package:uuid/uuid.dart';

class PlaylistRepoImpl implements PlaylistRepoInterface {
  PlaylistRepoImpl({required this.db});
  final Database db;

  @override
  Future<List<Playlist>> getPlaylists() async {
    final List<Map<String, dynamic>> playlists = await db.query('playlists');
    return playlists.map((e) => Playlist.fromJson(e)).toList();
  }

  @override
  Future<void> addPlaylist(String name) async {
    await db.insert('playlists', {'name': name, 'id': Uuid().v4()});
  }

  @override
  Future<void> updatePlaylist(String name, String id) async {
    await db.update(
      'playlists',
      {'name': name},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deletePlaylist(String id) async {
    await db.delete(
      'playlists',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<bool> checkIsDuplicate(String name) async {
    final List<Map<String, dynamic>> result = await db.query(
      'playlists',
      where: 'name = ?',
      whereArgs: [name],
    );
    return result.isNotEmpty;
  }
}
