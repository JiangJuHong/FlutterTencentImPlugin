import 'package:tencent_im_plugin/enums/group_member_role_enum.dart';

/// 群创建时需要传递的群成员实体
class GroupCreateMemberEntity {
  /// 用户ID
  late String userID;

  /// 角色
  GroupMemberRoleEnum? role;

  GroupCreateMemberEntity({
    required this.userID,
    this.role,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    if (this.role != null) data['role'] = GroupMemberRoleTool.toInt(this.role!);
    return data;
  }
}
