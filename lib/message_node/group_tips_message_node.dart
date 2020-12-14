import 'package:tencent_im_plugin/entity/group_changed_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_changed_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/enums/group_tips_type_enum.dart';
import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/list_util.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 群提示节点
class GroupTipsMessageNode extends MessageNode {
  /// 群ID
  String groupID;

  /// 群组事件通知类型
  GroupTipsTypeEnum type;

  /// 操作者
  GroupMemberEntity opMember;

  /// 被操作人列表
  List<GroupMemberEntity> memberList;

  /// 群资料变更信息列表，仅当tipsType值为V2TIMGroupTipsElem#V2TIM_GROUP_TIPS_TYPE_GROUP_INFO_CHANGE时有效
  List<GroupChangedInfoEntity> groupChangeInfoList;

  /// 群成员变更信息列表，仅当tipsType值为V2TIMGroupTipsElem#V2TIM_GROUP_TIPS_TYPE_MEMBER_INFO_CHANGE时有效
  List<GroupMemberChangedInfoEntity> memberChangeInfoList;

  /// 当前群成员数，仅当tipsType值为V2TIMGroupTipsElem#V2TIM_GROUP_TIPS_TYPE_JOIN, V2TIMGroupTipsElem#V2TIM_GROUP_TIPS_TYPE_QUIT, V2TIMGroupTipsElem#V2TIM_GROUP_TIPS_TYPE_KICKED的时候有效
  int memberCount;

  GroupTipsMessageNode() : super(MessageElemTypeEnum.GroupTips);

  GroupTipsMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageElemTypeEnum.GroupTips) {
    if (json["groupID"] != null) this.groupID = json["groupID"];
    if (json["type"] != null)
      this.type = GroupTipsTypeTool.getByInt(json["type"]);
    if (json["opMember"] != null)
      this.opMember = GroupMemberEntity.fromJson(json["opMember"]);
    if (json["memberList"] != null)
      this.memberList =
          ListUtil.generateOBJList<GroupMemberEntity>(json["memberList"]);
    if (json["groupChangeInfoList"] != null)
      this.groupChangeInfoList =
          ListUtil.generateOBJList<GroupChangedInfoEntity>(
              json["groupChangeInfoList"]);
    if (json["memberChangeInfoList"] != null)
      this.memberChangeInfoList =
          ListUtil.generateOBJList<GroupMemberChangedInfoEntity>(
              json["memberChangeInfoList"]);
    if (json["memberCount"] != null) this.memberCount = json["memberCount"];
  }
}
