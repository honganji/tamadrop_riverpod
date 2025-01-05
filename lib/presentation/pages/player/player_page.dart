import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:tamadrop_riverpod/domain/entity/video/video.dart';
import 'package:video_player/video_player.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage(this.video, {super.key});
  final Video video;

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isInitialized = false;
  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() {
    _videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
    );
    _videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoInitialize: true,
        autoPlay: true,
        showOptions: false,
        showControls: true,
        aspectRatio: 16 / 9,
        // customControls: MobileCustomControls(),
      );
      setState(() {
        _isInitialized = true;
      });
    });
  }

  @override
  void didUpdateWidget(covariant PlayerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.video.id != widget.video.id) {
      _updateVideoPlayer();
    }
  }

  void _updateVideoPlayer() {
    setState(() {
      _isInitialized = false;
    });
    _videoPlayerController.dispose();
    _chewieController.dispose();
    _initializeVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialized
        ? AspectRatio(
            aspectRatio: 16 / 9,
            child: ColoredBox(
              color: Theme.of(context).colorScheme.onPrimary,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          )
        : SizedBox(
            height: MediaQuery.of(context).size.width * 9 / 16,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
