/// 群申请处理结果枚举
enum GroupApplicationHandlerResultEnum {
  /// 拒绝
  Refuse,

  /// 接收
  Agree,
}

class GroupApplicationHandlerResultTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static GroupApplicationHandlerResultEnum getByInt(int index) =>
      GroupApplicationHandlerResultEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(GroupApplicationHandlerResultEnum level) => level.index;
}
