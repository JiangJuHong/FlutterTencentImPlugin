import 'dart:convert';

/// 消息发送进度实体
class MessageSendProgressEntity {
  /// 消息ID
  String msgId;

  /// 发送进度
  int progress;

  MessageSendProgressEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    msgId = json["msgId"];
    progress = json["progress"];
  }
}
