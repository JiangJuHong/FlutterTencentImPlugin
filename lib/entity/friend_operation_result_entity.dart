import 'dart:convert';

/// 好友操作结果实体
class FriendOperationResultEntity {
  /// 用户ID
  late String userID;

  /// 返回码
  late int resultCode;

  /// 返回信息
  String? resultInfo;

  FriendOperationResultEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['userID'] != null) userID = json['userID'];
    if (json['resultCode'] != null) resultCode = json['resultCode'];
    if (json['resultInfo'] != null) resultInfo = json['resultInfo'];
  }
}
