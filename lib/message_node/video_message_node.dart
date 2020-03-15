import 'package:flutter/cupertino.dart';
import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 语音消息节点
class VideoMessageNode extends MessageNode {
  /// 路径
  String path;

  /// 时长
  int duration;

  /// 类型
  String type;

  /// 缩略图宽度
  int snapshotWidth;

  /// 缩略图高度
  int snapshotHeight;

  /// 缩略图路径
  String snapshotPath;

  VideoMessageNode({
    @required this.path,
    @required this.duration,
    @required this.type,
    @required this.snapshotWidth,
    @required this.snapshotHeight,
    @required this.snapshotPath,
  }) : super(MessageNodeType.Video);

  VideoMessageNode.fromJson(Map<String, dynamic> json) : super(MessageNodeType.Video) {
    path = json['path'];
    duration = json['duration'];
    type = json['type'];
    snapshotWidth = json['snapshotWidth'];
    snapshotHeight = json['snapshotHeight'];
    snapshotPath = json['snapshotPath'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["path"] = this.path;
    data["duration"] = this.duration;
    data["type"] = this.type;
    data["snapshotWidth"] = this.snapshotWidth;
    data["snapshotHeight"] = this.snapshotHeight;
    data["snapshotPath"] = this.snapshotPath;
    return data;
  }
}
