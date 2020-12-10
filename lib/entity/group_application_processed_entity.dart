import 'dart:convert';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/enums/group_info_changed_type_enum.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群申请处理
class GroupApplicationProcessedEntity {
  /// 群ID
  String groupID;

  /// 操作用户
  GroupMemberEntity opUser;

  /// 操作原因
  String opReason;

  /// 是否同意加入
  bool isAgreeJoin;

  GroupApplicationProcessedEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    groupID = json['groupID'];
    opReason = json['opReason'];
    isAgreeJoin = json['isAgreeJoin'];
    if (json["opUser"] != null)
      opUser = GroupMemberEntity.fromJson(json['opUser']);
  }
}
