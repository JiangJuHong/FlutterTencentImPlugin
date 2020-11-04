/// 接收消息选项
enum GroupReceiveMessageOptEnum {
  /// 接收群消息，若离线情况下会推送离线消息
  ReceiveAndNotify,

  /// 不接收群消息
  NotReceive,

  /// 接收群消息，但若离线情况下则不会推送离线消息
  ReceiveNotNotify,
}

class GroupReceiveMessageOptTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static GroupReceiveMessageOptEnum getByInt(int index) =>
      GroupReceiveMessageOptEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(GroupReceiveMessageOptEnum level) => level.index;
}
