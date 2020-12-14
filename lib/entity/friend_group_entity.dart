import 'dart:convert';

/// 好友分组实体
class FriendGroupEntity {
  /// 组名
  String name;

  /// 好友数量
  int friendCount;

  /// 好友ID列表
  List<String> friendIDList;

  FriendGroupEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    name = json['name'];
    friendCount = json['friendCount'];
    friendIDList = json['friendIDList']?.cast<String>();
  }
}
