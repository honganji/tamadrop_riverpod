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
  Future<void> addVideo(Video video) {
    // TODO: implement addVideo
    throw UnimplementedError();
  }

  @override
  Future<void> updateVideo(Video video, String id) {
    // TODO: implement updateVideo
    throw UnimplementedError();
  }

  @override
  Future<void> deleteVideo(String id) {
    // TODO: implement deleteVideo
    throw UnimplementedError();
  }

  @override
  Future<bool> checkIsDuplicate(String title) {
    // TODO: implement checkIsDuplicate
    throw UnimplementedError();
  }
}
