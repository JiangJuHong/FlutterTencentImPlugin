import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/utils/enum_util.dart';

/// 消息节点
class MessageNode {
  /// 新消息节点类型
  MessageElemTypeEnum nodeType;

  MessageNode(
    this.nodeType,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["nodeType"] = MessageElemTypeTool.toInt(this.nodeType);
    return data;
  }
}
