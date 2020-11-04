/// 群申请类型枚举
enum GroupApplicationTypeEnum {
  /// 主动申请
  Join,

  /// 被邀请
  Invite,
}

class GroupApplicationTypeTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static GroupApplicationTypeEnum getByInt(int index) =>
      GroupApplicationTypeEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(GroupApplicationTypeEnum level) => level.index;
}
