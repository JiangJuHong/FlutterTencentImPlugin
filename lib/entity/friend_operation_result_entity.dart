import 'dart:convert';

/// 好友操作结果实体
class FriendOperationResultEntity {
  /// 用户ID
  String userID;

  /// 返回码
  int resultCode;

  /// 返回信息
  String resultInfo;

  FriendOperationResultEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    userID = json['userID'];
    resultCode = json['resultCode'];
    resultInfo = json['resultInfo'];
  }
}
