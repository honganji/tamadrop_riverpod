import 'package:tamadrop_riverpod/domain/entity/video/video.dart';

abstract interface class VideoRepoInterface {
  Future<List<Video>> getVideos();
  Future<void> addVideo(Video video);
  Future<void> updateVideo(Video video, String id);
  Future<void> deleteVideo(String id);
  Future<bool> checkIsDuplicate(String title);
}
