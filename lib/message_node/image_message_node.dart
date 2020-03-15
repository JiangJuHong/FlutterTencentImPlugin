import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 图片消息节点
class ImageMessageNode extends MessageNode {
  /// 图片路径
  String path;

  ImageMessageNode({
    @required this.path,
  }) : super(MessageNodeType.Image);

  ImageMessageNode.fromJson(Map<String, dynamic> json) : super(MessageNodeType.Image) {
    path = json['path'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["path"] = this.path;
    return data;
  }
}
