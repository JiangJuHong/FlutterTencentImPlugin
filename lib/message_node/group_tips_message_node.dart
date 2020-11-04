import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 群提示节点
class GroupTipsMessageNode extends MessageNode {
  /// 群ID
  String groupId;

  /// 群名
  String groupName;

  GroupTipsMessageNode() : super(MessageElemTypeEnum.GroupTips);

  GroupTipsMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageElemTypeEnum.GroupTips) {}

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}
