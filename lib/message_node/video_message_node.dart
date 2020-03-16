import 'package:flutter/cupertino.dart';
import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/message_node/entity/video_info_entity.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

import 'entity/video_snapshot_info_entity.dart';

/// 语音消息节点
class VideoMessageNode extends MessageNode {
  /// 视频缩略图信息
  VideoSnapshotInfo videoSnapshotInfo;

  /// 视频信息
  VideoInfo videoInfo;

  VideoMessageNode({
    @required this.videoSnapshotInfo,
    @required this.videoInfo,
  }) : super(MessageNodeType.Video);

  VideoMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageNodeType.Video) {
    videoSnapshotInfo = VideoSnapshotInfo.fromJson(json["videoSnapshotInfo"]);
    videoInfo = VideoInfo.fromJson(json["videoInfo"]);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["videoSnapshotInfo"] = this.videoSnapshotInfo.toJson();
    data["videoInfo"] = this.videoInfo.toJson();
    return data;
  }
}
