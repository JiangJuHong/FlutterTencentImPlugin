/// 消息状态
enum MessageStatusEnum {
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
