import 'dart:convert';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群解散或被回收通知实体
class GroupDismissedOrRecycledEntity {
  /// 群ID
  String groupID;

  /// 操作用户
  GroupMemberEntity opUser;

  GroupDismissedOrRecycledEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    groupID = json['groupID'];
    if (json["opUser"] != null)
      opUser = GroupMemberEntity.fromJson(json["opUser"]);
  }
}
