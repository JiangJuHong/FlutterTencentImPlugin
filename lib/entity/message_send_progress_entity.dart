import 'dart:convert';

/// 消息发送进度实体
class MessageSendProgressEntity {
  /// 消息ID
  late String msgId;

  /// 发送进度
  late int progress;

  MessageSendProgressEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['msgId'] != null) msgId = json["msgId"];
    if (json['progress'] != null) progress = json["progress"];
  }
}
