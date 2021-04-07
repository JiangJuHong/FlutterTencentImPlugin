import 'dart:convert';

/// 好友分组实体
class FriendGroupEntity {
  /// 组名
  late String name;

  /// 好友数量
  late int friendCount;

  /// 好友ID列表
  late List<String> friendIDList;

  FriendGroupEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['name'] != null) name = json['name'];
    if (json['friendCount'] != null) friendCount = json['friendCount'];
    if (json['friendIDList'] != null)
      friendIDList = json['friendIDList']?.cast<String>();
  }
}
