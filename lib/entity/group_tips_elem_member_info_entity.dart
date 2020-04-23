/// 群tips，成员变更信息
class GroupTipsElemMemberInfoEntity {
  /// 消息内容
  String identifier;

  /// 被禁言时间
  int shutupTime;

  GroupTipsElemMemberInfoEntity.fromJson(Map<String, dynamic> json) {
    identifier = json["identifier"];
    shutupTime = json["shutupTime"];
  }
}
