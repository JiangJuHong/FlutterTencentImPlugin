/// 群申请处理状态枚举
enum GroupApplicationHandlerStatusEnum {
  /// 未处理
  Unhandled,

  /// 其他人处理
  ByOther,

  /// 自己已处理
  BySelf,
}

class GroupApplicationHandlerStatusTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static GroupApplicationHandlerStatusEnum getByInt(int index) =>
      GroupApplicationHandlerStatusEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(GroupApplicationHandlerStatusEnum level) => level.index;
}
