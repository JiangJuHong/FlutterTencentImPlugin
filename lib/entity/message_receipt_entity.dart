import 'dart:convert';

/// 消息回执实体
class MessageReceiptEntity {
  /// 用户ID
  String userID;

  /// 时间
  int timestamp;

  MessageReceiptEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    userID = json["userID"];
    timestamp = json["timestamp"];
  }
}
