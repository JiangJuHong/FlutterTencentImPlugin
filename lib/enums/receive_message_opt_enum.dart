/// 接收消息选项
enum ReceiveMessageOptEnum {
  /// 在线正常接收消息，离线时会有厂商的离线推送通知
  ReceiveAndNotify,

  /// 不会接收到消息
  NotReceive,

  /// 在线正常接收消息，离线不会有推送通知
  ReceiveNotNotify,
}

class ReceiveMessageOptTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static ReceiveMessageOptEnum getByInt(int index) => ReceiveMessageOptEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(ReceiveMessageOptEnum level) => level.index;
}