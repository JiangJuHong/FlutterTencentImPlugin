import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群解散或被回收通知实体
class GroupDismissedOrRecycledEntity {
  /// 群ID
  String groupID;

  /// 操作用户
  GroupMemberEntity opUser;

  GroupDismissedOrRecycledEntity.fromJson(Map<String, dynamic> json) {
    groupID = json['groupID'];
    if (json["opUser"] != null)
      opUser = GroupMemberEntity.fromJson(json["opUser"]);
  }
}
