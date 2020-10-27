import 'package:tencent_im_plugin/enums/group_member_role_enum.dart';

/// 群创建时需要传递的群成员实体
class GroupCreateMemberEntity {
  /// 用户ID
  String userID;

  /// 角色
  GroupMemberRoleEnum role;

  GroupCreateMemberEntity({
    this.userID,
    this.role,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userID != null) data['userID'] = this.userID;
    if (this.role != null) data['role'] = GroupMemberRoleTool.toInt(this.role);
    return data;
  }
}
