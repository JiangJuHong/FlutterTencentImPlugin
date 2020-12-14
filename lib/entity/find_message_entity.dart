import 'package:flutter/cupertino.dart';

/// 查找消息实体
class FindMessageEntity {
  /// 消息ID
  String msgId;

  FindMessageEntity({
    @required this.msgId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["msgId"] = this.msgId;
    return data;
  }
}
