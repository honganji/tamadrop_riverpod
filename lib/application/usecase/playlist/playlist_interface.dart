abstract interface class PlaylistInterface {
  Future<void> getPlaylists();
  Future<void> addPlaylist(String name);
  Future<void> updatePlaylist(String name, String id);
  Future<void> deletePlaylist(String id);
  Future<void> checkIsDuplicate(String name);
}
