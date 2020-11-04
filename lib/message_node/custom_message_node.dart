import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 自定义消息节点
class CustomMessageNode extends MessageNode {
  /// 自定义数据
  String data;

  CustomMessageNode({
    @required this.data,
  }) : super(MessageElemTypeEnum.Custom);

  CustomMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageElemTypeEnum.Custom) {
    data = json['data'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["data"] = this.data;
    return data;
  }
}
