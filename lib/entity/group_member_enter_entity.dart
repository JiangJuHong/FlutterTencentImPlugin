import 'dart:convert';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群成员加入通知实体
class GroupMemberEnterEntity {
  /// 群ID
  late String groupID;

  /// 群成员列表
  late List<GroupMemberEntity> memberList;

  GroupMemberEnterEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['groupID'] != null) groupID = json['groupID'];
    if (json["memberList"] != null)
      memberList =
          ListUtil.generateOBJList<GroupMemberEntity>(json['memberList']);
  }
}
