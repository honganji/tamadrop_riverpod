abstract interface class VideoInterface {
  Future<void> getVideos();
  Future<void> getVideosByCategory(String pid);
  Future<void> addVideo(String url, String? pid);
  Future<void> deleteVideo(String id);
  Future<bool> checkIsDuplicate(String name);
}
