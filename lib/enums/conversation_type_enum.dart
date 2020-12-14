/// 会话类型枚举
enum ConversationTypeEnum {
  /// 非法类型
  Invalid,

  /// 单聊
  C2C,

  /// 群聊
  Group,
}

class ConversationTypeTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static ConversationTypeEnum getByInt(int index) =>
      ConversationTypeEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(ConversationTypeEnum level) => level.index;
}
