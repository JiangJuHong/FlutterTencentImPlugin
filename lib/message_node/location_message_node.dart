import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 位置节点
class LocationMessageNode extends MessageNode {
  /// 自定义数据
  String data;

  LocationMessageNode({
    @required this.data,
  })  : super(MessageNodeType.Location);

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["data"] = this.data;
    return data;
  }
}
