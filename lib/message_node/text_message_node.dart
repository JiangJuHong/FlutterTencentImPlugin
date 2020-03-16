import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 文本消息节点
class TextMessageNode extends MessageNode {
  /// 文本内容
  String content;

  TextMessageNode({
    @required this.content,
  }) : super(MessageNodeType.Text);

  TextMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageNodeType.Text) {
    content = json['content'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["content"] = this.content;
    return data;
  }
}
