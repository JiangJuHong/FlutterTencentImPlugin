import 'dart:convert';

/// 消息回执实体
class MessageReceiptEntity {
  /// 用户ID
  late String userID;

  /// 时间
  int? timestamp;

  MessageReceiptEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['userID'] != null) userID = json["userID"];
    if (json['timestamp'] != null) timestamp = json["timestamp"];
  }
}
