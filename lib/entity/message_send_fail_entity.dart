import 'dart:convert';

/// 消息发送失败实体
class MessageSendFailEntity {
  /// 消息ID
  late String msgId;

  /// 错误码
  late int code;

  /// 错误描述
  String? desc;

  MessageSendFailEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['msgId'] != null) msgId = json["msgId"];
    if (json['code'] != null) code = json["code"];
    if (json['desc'] != null) desc = json["desc"];
  }
}
