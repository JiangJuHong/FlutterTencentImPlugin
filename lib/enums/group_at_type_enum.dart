/// 群@类型枚举
enum GroupAtTypeEnum {
  /// 非法类型
  Unknown,

  /// @我
  AtMe,

  /// @所有人
  AtAll,

  /// @群里所有人，并单独@我
  AtAllAtMe
}

class GroupAtTypeTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static GroupAtTypeEnum getByInt(int index) => GroupAtTypeEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(GroupAtTypeEnum level) => level.index;
}
