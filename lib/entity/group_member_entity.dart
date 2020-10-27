import 'package:tencent_im_plugin/enums/group_member_role_enum.dart';

/// 群成员实体
class GroupMemberEntity {
  /// 用户ID
  String userID;

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
    this.role,
    this.customInfo,
    this.nameCard,
  });

  GroupMemberEntity.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    role = GroupMemberRoleTool.getByInt(json['role']);
    muteUntil = json['muteUntil'];
    joinTime = json['joinTime'];
    customInfo = (json['customInfo'] as Map).cast<String, String>();
    nameCard = json['nameCard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userID != null) data['userID'] = this.userID;
    if (this.role != null) data['role'] = GroupMemberRoleTool.toInt(this.role);
    if (this.customInfo != null) data['customInfo'] = this.customInfo;
    if (this.nameCard != null) data['nameCard'] = this.nameCard;
    return data;
  }
}
