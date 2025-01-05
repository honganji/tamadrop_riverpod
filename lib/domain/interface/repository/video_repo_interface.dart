import 'package:tamadrop_riverpod/domain/entity/video/video.dart';

abstract interface class VideoRepoInterface {
  Future<List<Video>> getVideos();
  Future<List<Video>> getVideosByCategory(String pid);
  Future<void> addVideo(Video video, String? pid);
  Future<void> updateVideo(Video video, String id);
  Future<void> deleteVideo(String id);
  Future<bool> checkIsDuplicate(String title);
  Future<String> getAllId();
}
