import 'package:tamadrop_riverpod/application/usecase/progress/progress.dart';
import 'package:tamadrop_riverpod/domain/entity/video/video.dart';

abstract interface class DownloadApiInterface {
  Future<Video> downloadVideo(String url, Progress notifier);
}
