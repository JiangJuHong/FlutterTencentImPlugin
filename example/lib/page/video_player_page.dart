import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:video_player/video_player.dart';

/// 视频播放页面
class VideoPlayerPage extends StatefulWidget {
  final String file;

  const VideoPlayerPage({Key key, this.file}) : super(key: key);

  @override
  State<StatefulWidget> createState() => VideoPlayerPageState();
}

class VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(new File(widget.file));
    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.initialize().then((_) {
        setState(() {});
        controller.play();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoPlayer(controller),
    );
  }
}
