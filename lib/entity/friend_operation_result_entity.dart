/// 好友操作结果实体
class FriendOperationResultEntity {
  /// 用户ID
  String userID;

  /// 返回码
  int resultCode;

  /// 返回信息
  String resultInfo;

  FriendOperationResultEntity.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    resultCode = json['resultCode'];
    resultInfo = json['resultInfo'];
  }
}
