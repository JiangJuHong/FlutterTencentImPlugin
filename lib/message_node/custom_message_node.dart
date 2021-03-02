import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 自定义消息节点
class CustomMessageNode extends MessageNode {
  /// 自定义数据
  String data;

  /// 描述信息
  String desc;

  /// 扩展信息
  String ext;

  CustomMessageNode({
    @required this.data,
    this.desc,
    this.ext,
  }) : super(MessageElemTypeEnum.Custom);

  CustomMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageElemTypeEnum.Custom) {
    data = json['data'];
    desc = json['desc'];
    ext = json['ext'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["data"] = this.data;
    data["desc"] = this.desc;
    data["ext"] = this.ext;
    return data;
  }
}
