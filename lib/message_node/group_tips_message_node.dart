import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/entity/group_tips_elem_group_info_entity.dart';
import 'package:tencent_im_plugin/entity/group_tips_elem_member_info_entity.dart';
import 'package:tencent_im_plugin/entity/user_info_entity.dart';
import 'package:tencent_im_plugin/enums/group_tips_type.dart';
import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/list_util.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';
import 'package:tencent_im_plugin/utils/enum_util.dart';

/// 群提示节点
class GroupTipsMessageNode extends MessageNode {
  /// 群ID
  String groupId;

  /// 群名
  String groupName;

  /// 被操作者群内资料
  Map<String, GroupMemberEntity> changedGroupMemberInfo;

  /// 被操作账号的个人资料
  Map<String, UserInfoEntity> changedUserInfo;

  /// 群资料变更列表信息 仅当tipsType值为TIMGroupTipsType.ModifyGroupInfo时有效
  List<GroupTipsElemGroupInfoEntity> groupInfoList;

  /// 群成员变更信息列表，仅当tipsType值为TIMGroupTipsType.ModifyMemberInfo时有效
  List<GroupTipsElemMemberInfoEntity> memberInfoList;

  /// 群成员数量
  int memberNum;

  /// 操作者群内资料
  GroupMemberEntity opGroupMemberInfo;

  /// 操作者ID
  String opUser;

  /// 操作者用户资料
  UserInfoEntity opUserInfo;

  /// 操作方平台资料
  String platform;

  /// 类型
  GroupTipsType tipsType;

  /// 被操作的帐号列表
  List<String> userList;

  GroupTipsMessageNode() : super(MessageNodeType.GroupTips);

  GroupTipsMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageNodeType.GroupTips) {
    groupId = json["groupId"];
    groupName = json["groupName"];

    if (json["changedGroupMemberInfo"] != null) {
      Map<String, GroupMemberEntity> value = {};
      json["changedGroupMemberInfo"].forEach((k, v) {
        value[k] = GroupMemberEntity.fromJson(v);
      });
      changedGroupMemberInfo = value;
    }

    if (json["changedUserInfo"] != null) {
      Map<String, UserInfoEntity> value = {};
      json["changedUserInfo"].forEach((k, v) {
        value[k] = UserInfoEntity.fromJson(v);
      });
      changedUserInfo = value;
    }

    if (json["groupInfoList"] != null) {
      groupInfoList = ListUtil.generateOBJList<GroupTipsElemGroupInfoEntity>(
          json["groupInfoList"]);
    }

    if (json["memberInfoList"] != null) {
      memberInfoList = ListUtil.generateOBJList<GroupTipsElemMemberInfoEntity>(
          json["memberInfoList"]);
    }

    memberNum = json["memberNum"];

    if (json["opGroupMemberInfo"] != null) {
      opGroupMemberInfo = GroupMemberEntity.fromJson(json["opGroupMemberInfo"]);
    }

    opUser = json["opUser"];

    if (json["opUserInfo"] != null) {
      opUserInfo = UserInfoEntity.fromJson(json["opUserInfo"]);
    }
    platform = json["platform"];
    tipsType = EnumUtil.nameOf(GroupTipsType.values, json["tipsType"]);
    if (json["userList"] != null) {
      userList = List<String>.from(json["userList"]);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}
