import 'dart:convert';
import 'package:tencent_im_plugin/enums/group_member_role_enum.dart';

/// 群成员实体
class GroupMemberEntity {
  /// 用户ID
  String userID;

  /// 用户昵称
  String nickName;

  /// 好友备注
  String friendRemark;

  /// 头像URL
  String faceUrl;

  /// 角色
  GroupMemberRoleEnum role;

  /// 群成员禁言结束时间戳
  int muteUntil;

  /// 加入时间
  int joinTime;

  /// 自定义字段
  Map<String, String> customInfo;

  /// 群成员名片
  String nameCard;

  GroupMemberEntity({
    this.userID,
    this.customInfo,
    this.nameCard,
  });

  GroupMemberEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    userID = json['userID'];
    nickName = json['nickName'];
    friendRemark = json['friendRemark'];
    faceUrl = json['faceUrl'];
    if (json['role'] != null) role = GroupMemberRoleTool.getByInt(json['role']);
    muteUntil = json['muteUntil'];
    joinTime = json['joinTime'];
    if (json['customInfo'] != null)
      customInfo = (json['customInfo'] as Map).cast<String, String>();
    nameCard = json['nameCard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userID != null) data['userID'] = this.userID;
    if (this.customInfo != null) data['customInfo'] = this.customInfo;
    if (this.nameCard != null) data['nameCard'] = this.nameCard;
    return data;
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is GroupMemberEntity && runtimeType == other.runtimeType && userID == other.userID;

  @override
  int get hashCode => userID.hashCode;
}
