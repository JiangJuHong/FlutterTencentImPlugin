import 'package:flutter/cupertino.dart';

/// 视频缩略图信息
class VideoSnapshotInfo {
  /// 图片Id
  String uuid;

  /// 图片大小
  int size;

  /// 图片宽度
  int width;

  /// 图片高度
  int height;

  /// 路径
  String path;

  VideoSnapshotInfo({
    @required this.width,
    @required this.height,
    @required this.path,
  });

  VideoSnapshotInfo.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    size = json['size'];
    width = json['width'];
    height = json['height'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['path'] = this.path;
    return data;
  }
}
