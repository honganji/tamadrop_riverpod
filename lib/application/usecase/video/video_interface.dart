abstract interface class VideoInterface {
  Future<void> getVideos();
  Future<void> getVideosByCategory(String pid);
  Future<void> addVideo(String name);
  Future<void> updateVideo(String name, String id);
  Future<void> deleteVideo(String id);
  Future<void> checkIsDuplicate(String name);
  Future<void> downloadVideo(String url);
}
