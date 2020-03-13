import 'package:flutter/cupertino.dart';
import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 语音消息节点
class SoundMessageNode extends MessageNode {
  /// 路径
  String path;

  /// 时长
  int duration;

  SoundMessageNode({
    @required this.path,
    @required this.duration,
  })  : super(MessageNodeType.Sound);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["path"] = this.path;
    data["duration"] = this.duration;
    return data;
  }
}
