import 'dart:convert';
import 'package:tencent_im_plugin/list_util.dart';

/// 群成员改变通知实体
class GroupMemberChangedEntity {
  /// 群ID
  String? groupID;

  /// 群成员列表
  List<GroupMemberChangedInfoEntity>? changInfo;

  GroupMemberChangedEntity.fromJson(data) {
    Map<String, dynamic> json = data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['groupID'] != null) groupID = json['groupID'];
    if (json["changInfo"] != null) changInfo = ListUtil.generateOBJList<GroupMemberChangedInfoEntity>(json['changInfo']) as List<GroupMemberChangedInfoEntity>?;
  }
}

/// 群成员改变信息实体
class GroupMemberChangedInfoEntity {
  /// 用户ID
  String? userID;

  /// 禁言时长
  int? muteTime;

  GroupMemberChangedInfoEntity.fromJson(data) {
    Map<String, dynamic> json = data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['userID'] != null) userID = json['userID'];
    if (json['muteTime'] != null) muteTime = json['muteTime'];
  }
}
