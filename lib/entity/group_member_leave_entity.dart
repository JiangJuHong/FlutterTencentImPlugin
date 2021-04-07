import 'dart:convert';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';

/// 群成员离开通知实体
class GroupMemberLeaveEntity {
  /// 群ID
  late String groupID;

  /// 群成员信息
  late GroupMemberEntity member;

  GroupMemberLeaveEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['groupID'] != null) groupID = json['groupID'];
    if (json["member"] != null)
      member = GroupMemberEntity.fromJson(json["member"]);
  }
}
