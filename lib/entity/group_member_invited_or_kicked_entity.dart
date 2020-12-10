import 'dart:convert';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群成员邀请或提出通知实体
class GroupMemberInvitedOrKickedEntity {
  /// 群ID
  String groupID;

  /// 群成员列表信息
  List<GroupMemberEntity> memberList;

  /// 操作用户
  GroupMemberEntity opUser;

  GroupMemberInvitedOrKickedEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    groupID = json['groupID'];
    if (json["memberList"] != null)
      memberList =
          ListUtil.generateOBJList<GroupMemberEntity>(json['memberList']);
    if (json["opUser"] != null)
      opUser = GroupMemberEntity.fromJson(json["opUser"]);
  }
}
