import 'dart:convert';
import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 其它节点
class OtherMessageNode extends MessageNode {
  /// 参数
  Map<String, dynamic> params;

  OtherMessageNode() : super(MessageNodeType.Other);

  OtherMessageNode.fromJson(Map<String, dynamic> json) : super(MessageNodeType.Other) {
    params = jsonDecode(json['params']);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}
