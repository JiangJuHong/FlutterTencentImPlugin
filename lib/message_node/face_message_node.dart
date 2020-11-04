import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 表情消息节点
class FaceMessageNode extends MessageNode {
  /// 索引
  int index;

  /// 数据
  String data;

  FaceMessageNode({
    @required this.index,
    @required this.data,
  }) : super(MessageElemTypeEnum.Face);

  FaceMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageElemTypeEnum.Face) {
    this.index = json["index"];
    this.data = json["data"];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["index"] = this.index;
    data["data"] = this.data;
    return data;
  }
}
