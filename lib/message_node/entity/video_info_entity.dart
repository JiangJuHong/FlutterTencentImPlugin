import 'package:flutter/cupertino.dart';

/// 视频信息
class VideoInfo {
  /// 视频ID
  String uuid;

  /// 时长
  int duration;

  /// 大小
  int size;

  /// 类型
  String type;

  /// 路径
  String path;

  VideoInfo({
    @required this.duration,
    @required this.type,
    @required this.path,
  });

  VideoInfo.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    duration = json['duration'];
    size = json['size'];
    type = json['type'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['type'] = this.type;
    data['path'] = this.path;
    return data;
  }
}
