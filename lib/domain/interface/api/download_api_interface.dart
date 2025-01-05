import 'package:tamadrop_riverpod/domain/entity/video/video.dart';

abstract interface class DownloadApiInterface {
  Future<Video> downloadVideo();
}
