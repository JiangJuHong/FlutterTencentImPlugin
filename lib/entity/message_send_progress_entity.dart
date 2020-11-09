/// 消息发送进度实体
class MessageSendProgressEntity {
  /// 消息ID
  String msgId;

  /// 发送进度
  int progress;

  MessageSendProgressEntity.fromJson(Map<String, dynamic> json) {
    msgId = json["msgId"];
    progress = json["progress"];
  }
}
