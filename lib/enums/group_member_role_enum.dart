/// 群成员角色枚举
enum GroupMemberRoleEnum {
  /// 未定义
  Undefined,

  /// 群成员
  Member,

  /// 群管理员
  Admin,

  /// 群主
  Owner,
}

class GroupMemberRoleTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static GroupMemberRoleEnum getByInt(int index) {
    switch (index) {
      case 0:
        return GroupMemberRoleEnum.Undefined;
      case 200:
        return GroupMemberRoleEnum.Member;
      case 300:
        return GroupMemberRoleEnum.Admin;
      case 400:
        return GroupMemberRoleEnum.Owner;
    }
    throw ArgumentError("参数异常");
  }

  /// 将枚举转换为整型
  static int toInt(GroupMemberRoleEnum role) {
    switch (role) {
      case GroupMemberRoleEnum.Undefined:
        return 0;
      case GroupMemberRoleEnum.Member:
        return 200;
      case GroupMemberRoleEnum.Admin:
        return 300;
      case GroupMemberRoleEnum.Owner:
        return 400;
    }
    throw ArgumentError("参数异常");
  }
}
