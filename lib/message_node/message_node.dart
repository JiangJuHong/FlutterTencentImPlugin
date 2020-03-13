import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/utils/enum_util.dart';

/// 消息节点
class MessageNode {
  /// 新消息节点类型
  MessageNodeType nodeType;

  MessageNode(
    this.nodeType,
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["nodeType"] = EnumUtil.getEnumName(this.nodeType);
    return data;
  }
}
