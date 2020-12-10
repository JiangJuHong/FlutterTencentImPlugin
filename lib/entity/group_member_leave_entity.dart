import 'dart:convert';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群成员离开通知实体
class GroupMemberLeaveEntity {
  /// 群ID
  String groupID;

  /// 群成员信息
  GroupMemberEntity member;

  GroupMemberLeaveEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    groupID = json['groupID'];
    if (json["member"] != null)
      member = GroupMemberEntity.fromJson(json["member"]);
  }
}
