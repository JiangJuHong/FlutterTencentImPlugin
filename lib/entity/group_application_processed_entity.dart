import 'dart:convert';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';

/// 群申请处理
class GroupApplicationProcessedEntity {
  /// 群ID
  late String groupID;

  /// 操作用户
  GroupMemberEntity? opUser;

  /// 操作原因
  String? opReason;

  /// 是否同意加入
  bool? isAgreeJoin;

  GroupApplicationProcessedEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['groupID'] != null) groupID = json['groupID'];
    if (json['opReason'] != null) opReason = json['opReason'];
    if (json['isAgreeJoin'] != null) isAgreeJoin = json['isAgreeJoin'];
    if (json["opUser"] != null)
      opUser = GroupMemberEntity.fromJson(json['opUser']);
  }
}
