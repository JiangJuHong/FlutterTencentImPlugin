/// 消息发送失败实体
class MessageSendFailEntity{
  /// 消息ID
  String msgId;

  /// 错误码
  int code;

  /// 错误描述
  String desc;

  MessageSendFailEntity.fromJson(Map<String, dynamic> json) {
    msgId = json["msgId"];
    code = json["code"];
    desc = json["desc"];
  }
}