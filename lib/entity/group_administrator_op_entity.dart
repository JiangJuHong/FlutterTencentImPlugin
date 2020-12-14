import 'dart:convert';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群管理员操作通知实体
class GroupAdministratorOpEntity {
  /// 群ID
  String groupID;

  /// 群成员列表
  List<GroupMemberEntity> changInfo;

  /// 操作用户
  GroupMemberEntity opUser;

  GroupAdministratorOpEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    groupID = json['groupID'];
    if (json["changInfo"] != null)
      changInfo =
          ListUtil.generateOBJList<GroupMemberEntity>(json['changInfo']);
    if (json["opUser"] != null)
      opUser = GroupMemberEntity.fromJson(json["opUser"]);
  }
}
