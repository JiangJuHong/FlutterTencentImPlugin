/// 好友分组实体
class FriendGroupEntity {
  /// 组名
  String name;

  /// 好友数量
  int friendCount;

  /// 好友ID列表
  List<String> friendIDList;

  FriendGroupEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    friendCount = json['friendCount'];
    friendIDList = json['friendIDList'];
  }
}
