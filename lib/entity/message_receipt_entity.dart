/// 消息回执实体
class MessageReceiptEntity {
  /// 用户ID
  String userID;

  /// 时间
  int timestamp;

  MessageReceiptEntity.fromJson(Map<String, dynamic> json) {
    userID = json["userID"];
    timestamp = json["timestamp"];
  }
}
