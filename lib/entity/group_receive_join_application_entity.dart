import 'dart:convert';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/enums/group_info_changed_type_enum.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群加入申请实体
class GroupReceiveJoinApplicationEntity {
  /// 群ID
  String groupID;

  /// 群成员
  GroupMemberEntity member;

  /// 操作原因
  String opReason;

  GroupReceiveJoinApplicationEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    groupID = json['groupID'];
    opReason = json['opReason'];
    if (json["member"] != null)
      member = GroupMemberEntity.fromJson(json['member']);
  }
}
