/// 消息状态
enum MessageStatusEnum {
  /// 未知
  Unknown,

  /// 发送中
  Sending,

  /// 发送成功
  SendSucc,

  /// 发送失败
  SendFail,

  /// 删除
  HasDeleted,

  /// 已撤回
  HasRevoked,
}

class MessageStatusTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static MessageStatusEnum getByInt(int index) {
    switch (index) {
      case 0:
        return MessageStatusEnum.Unknown;
      case 1:
        return MessageStatusEnum.Sending;
      case 2:
        return MessageStatusEnum.SendSucc;
      case 3:
        return MessageStatusEnum.SendFail;
      case 4:
        return MessageStatusEnum.HasDeleted;
      case 6:
        return MessageStatusEnum.HasRevoked;
    }
    throw ArgumentError("参数异常");
  }

  /// 将枚举转换为整型
  static int toInt(MessageStatusEnum status) {
    switch (status) {
      case MessageStatusEnum.Unknown:
        return 0;
      case MessageStatusEnum.Sending:
        return 1;
      case MessageStatusEnum.SendSucc:
        return 2;
      case MessageStatusEnum.SendFail:
        return 3;
      case MessageStatusEnum.HasDeleted:
        return 4;
      case MessageStatusEnum.HasRevoked:
        return 6;
    }
    throw ArgumentError("参数异常");
  }
}
