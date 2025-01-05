import 'package:sqflite/sqflite.dart';
import 'package:tamadrop_riverpod/domain/entity/video/video.dart';
import 'package:tamadrop_riverpod/domain/interface/repository/video_repo_interface.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class VideoRepoImpl implements VideoRepoInterface {
  VideoRepoImpl({required this.db});
  final Database db;

  @override
  Future<List<Video>> getVideos() async {
    var appDocDir = await getApplicationDocumentsDirectory();
    List<Map<String, dynamic>> dataList = await db.query("videos");
    List<Video> videoList = dataList.map<Video>((video) {
      Video data = Video.fromJson(video);
      Video tmp = Video(
        id: data.id,
        path: path.join(appDocDir.path, data.path),
        createdAt: data.createdAt,
        thumbnailFilePath: path.join(appDocDir.path, data.thumbnailFilePath),
        title: data.title,
        volume: data.volume,
        length: data.length,
      );
      return tmp;
    }).toList();
    return videoList;
  }

  @override
  Future<List<Video>> getVideosByCategory(String pid) async {
    var appDocDir = await getApplicationDocumentsDirectory();
    List<Map<String, dynamic>> dataList = await db.rawQuery('''
        SELECT videos.*
        FROM videos
        INNER JOIN playlist_videos ON vid = videos.id
        WHERE playlist_videos.pid = ?
        ORDER BY videos.created_at DESC
      ''', [pid]);
    List<Video> videoList = dataList.map<Video>((video) {
      Video data = Video.fromJson(video);
      Video tmp = Video(
        id: data.id,
        path: path.join(appDocDir.path, data.path),
        createdAt: data.createdAt,
        thumbnailFilePath: path.join(appDocDir.path, data.thumbnailFilePath),
        title: data.title,
        volume: data.volume,
        length: data.length,
      );
      return tmp;
    }).toList();
    return videoList;
  }

  @override
  Future<void> addVideo(Video video, String? pid) async {
    String allId = await getAllId();
    await db.insert('videos', video.toJson());
    await db.insert('playlist_videos', {'pid': allId, 'vid': video.id});
    if (pid != null) {
      await db.insert('playlist_videos', {'pid': pid, 'vid': video.id});
    }
  }

  @override
  Future<void> deleteVideo(String id) async {
    List<Map<String, dynamic>> vpList = await db.query(
      'playlist_videos',
    );
    await db.delete(
      'videos',
      where: 'id = ?',
      whereArgs: [id],
    );
    await db.delete(
      'playlist_videos',
      where: 'vid = ?',
      whereArgs: [id],
    );
    vpList = await db.query(
      'playlist_videos',
    );
  }

  @override
  Future<bool> checkIsDuplicate(String title) async {
    final List<Video> videoList = await getVideos();
    for (Video video in videoList) {
      if (video.title == title) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<String> getAllId() async {
    List<Map<String, dynamic>> allId = await db.rawQuery('''
      SELECT playlists.id
      FROM playlists
      WHERE playlists.name = ?
    ''', ['all']);
    return (allId[0]['id']);
  }
}
