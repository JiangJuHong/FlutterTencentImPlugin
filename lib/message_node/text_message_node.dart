import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 文本消息节点
class TextMessageNode extends MessageNode {
  /// 文本内容
  String content;

  /// @的用户列表，只在群聊中有效
  List<String> _atUserList;

  /// 是否需要@所有人
  bool _atAll;

  TextMessageNode({
    @required this.content,
    List<String> atUserList,
    bool atAll: false,
  })  : this._atUserList = atUserList,
        this._atAll = atAll,
        super(MessageElemTypeEnum.Text);

  TextMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageElemTypeEnum.Text) {
    content = json['content'];
  }

  /// 设置@列表
  set atUserList(List<String> value) => _atUserList = value;

  /// 设置@所有人
  set atAll(bool value) => _atAll = value;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["content"] = this.content;
    data["atUserList"] = this._atUserList;
    data["atAll"] = this._atAll;
    return data;
  }
}
