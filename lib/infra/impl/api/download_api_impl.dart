import 'dart:io';

import 'package:ffmpeg_kit_flutter_audio/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_audio/return_code.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tamadrop_riverpod/domain/entity/video/video.dart' as local;
import 'package:tamadrop_riverpod/domain/interface/api/download_api_interface.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class DownloadApiImpl implements DownloadApiInterface {
  DownloadApiImpl(this.url);
  final String url;
  late YoutubeExplode yt;
  late Video video;
  late StreamManifest manifest;
  late AudioOnlyStreamInfo streamAudioInfo;
  late VideoOnlyStreamInfo streamVideoInfo;
  late Stream<List<int>> audioStream;
  late Stream<List<int>> videoStream;
  late String appDocDir;
  late String videoDirName;
  late String id;
  late String audioFilePath;
  late String videoFilePath;
  late String outputFilePath;
  late File audioFile;
  late File videoFile;
  late IOSink audioFileStream;
  late IOSink videoFileStream;
  final String time = DateTime.now().millisecondsSinceEpoch.toString();
  late String thumbnailPath;
  late String relativeThumbnailPath;
  late String relativeVideoPath;

  @override
  Future<local.Video> downloadVideo() async {
    await _setup(url);
    await getFileAndPath();
    await _writeIntoFile();
    await _closeFiles();
    await _mergeAudioAndVideo();
    await _deleteVideo();
    await _getThumbnail();
    return local.Video(
      id: id,
      path: relativeVideoPath,
      createdAt: DateTime.now(),
      thumbnailFilePath: relativeThumbnailPath,
      title: video.title,
      volume: ((await File(path.join(appDocDir, relativeVideoPath)).length()) /
              1024 /
              1024)
          .toInt(),
      length: video.duration?.inSeconds ?? 0,
    );
  }

  Future<String> _exeFFmpeg(String command) async {
    var session = await FFmpegKit.execute(command);
    var returnCode = await session.getReturnCode();
    if (ReturnCode.isSuccess(returnCode)) {
      return 'success';
    } else {
      return (await session.getOutput())!;
    }
  }

  Future<void> _setup(String url) async {
    yt = YoutubeExplode();
    video = await yt.videos.get(url);
    id = video.id.value;
    manifest = await yt.videos.streams.getManifest(video.id);
    if (manifest.audioOnly.isEmpty || manifest.videoOnly.isEmpty) {
      throw Exception("No audio or video streams available for this video.");
    }
    streamAudioInfo = manifest.audioOnly.withHighestBitrate();
    // TODO enable to choose the quality of video
    streamVideoInfo = manifest.videoOnly.firstWhere(
      (stream) => stream.qualityLabel == '1080p',
      orElse: () => manifest.videoOnly.withHighestBitrate(),
    );
    audioStream = yt.videos.streams.get(streamAudioInfo);
    videoStream = yt.videos.streams.get(streamVideoInfo);
  }

  Future<void> getFileAndPath() async {
    appDocDir = (await getApplicationDocumentsDirectory()).path;
    videoDirName = "videos";
    relativeVideoPath = "$videoDirName/$id.mp4";
    final videoDir = Directory('$appDocDir/$videoDirName');
    if (!await videoDir.exists()) {
      await videoDir.create(recursive: true);
    }
    audioFilePath =
        path.join(appDocDir, '${id}_audio.${streamAudioInfo.container.name}');
    videoFilePath =
        path.join(appDocDir, '${id}_video.${streamVideoInfo.container.name}');
    outputFilePath = path.join(appDocDir, relativeVideoPath);
    audioFile = File(audioFilePath);
    videoFile = File(videoFilePath);
  }

  Future<void> _writeIntoFile() async {
    audioFileStream = audioFile.openWrite();
    videoFileStream = videoFile.openWrite();

    int totalData = streamAudioInfo.size.totalBytes.toInt() +
        streamVideoInfo.size.totalBytes.toInt();
    int downloadedData = 0;

    await for (var data in audioStream) {
      downloadedData += data.length;
      // TODO Track the progress of downloading audio
      // progressCubit.updateProgress(downloadedData / totalData * 100);
      audioFileStream.add(data);
    }

    await for (var data in videoStream) {
      downloadedData += data.length;
      // TODO Track the progress of downloading video
      // progressCubit.updateProgress(downloadedData / totalData * 100);
      videoFileStream.add(data);
    }
    // TODO reset the progress
    // progressCubit.updateProgress(0);
  }

  Future<void> _closeFiles() async {
    await audioFileStream.flush();
    await audioFileStream.close();
    await videoFileStream.flush();
    await videoFileStream.close();
  }

  Future<void> _mergeAudioAndVideo() async {
    var mergeCommand =
        '-i $videoFilePath -i $audioFilePath -c:v copy -c:a aac $outputFilePath';
    late var mergeResult;
    try {
      mergeResult = await _exeFFmpeg(mergeCommand);
    } catch (e) {
      Exception(e.toString());
    }

    if (mergeResult != 'success') {
      Exception('Error during merging: $mergeResult');
    }
  }

  Future<void> _deleteVideo() async {
    await audioFile.delete();
    await videoFile.delete();
  }

  Future<void> _getThumbnail() async {
    const thumbnailDirName = "thumbnails";
    relativeThumbnailPath = "$thumbnailDirName/$id.jpg";
    final thumbnailDir = Directory('$appDocDir/$thumbnailDirName');
    if (!await thumbnailDir.exists()) {
      await thumbnailDir.create(recursive: true);
    }
    final thumbnailFilePath = path.join(appDocDir, relativeThumbnailPath);
    // Fetch the image from the URL
    final response = await http.get(Uri.parse(video.thumbnails.highResUrl));

    // Save the image to the local storage
    final thumbnailFile = File(thumbnailFilePath);
    await thumbnailFile.writeAsBytes(response.bodyBytes);
  }
}
