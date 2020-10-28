/// 群成员过滤枚举
enum GroupMemberFilterEnum {
  /// 所有类型
  All,

  /// 群主
  Owner,

  /// 群管理员
  Admin,

  /// 普通群成员
  Common,
}

class GroupMemberFilterTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static GroupMemberFilterEnum getByInt(int index) {
    switch (index) {
      case 0:
        return GroupMemberFilterEnum.All;
      case 1:
        return GroupMemberFilterEnum.Owner;
      case 2:
        return GroupMemberFilterEnum.Admin;
      case 4:
        return GroupMemberFilterEnum.Common;
    }
    throw ArgumentError("参数异常");
  }

  /// 将枚举转换为整型
  static int toInt(GroupMemberFilterEnum role) {
    switch (role) {
      case GroupMemberFilterEnum.All:
        return 0;
      case GroupMemberFilterEnum.Owner:
        return 1;
      case GroupMemberFilterEnum.Admin:
        return 2;
      case GroupMemberFilterEnum.Common:
        return 4;
    }
    throw ArgumentError("参数异常");
  }
}
