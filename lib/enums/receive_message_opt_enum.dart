/// 接收消息选项
enum ReceiveMessageOptEnum {
  /// 不接收群消息
  NotReceive,

  /// 接收群消息，但若离线情况下则不会推送离线消息
  ReceiveNotNotify,

  /// 接收群消息，若离线情况下会推送离线消息
  ReceiveAndNotify,
}
