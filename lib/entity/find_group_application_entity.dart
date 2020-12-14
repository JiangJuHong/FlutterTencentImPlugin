/// 查找群申请实体
class FindGroupApplicationEntity {
  /// 来自用户
  String fromUser;

  /// 群ID
  String groupID;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["fromUser"] = fromUser;
    data["groupID"] = groupID;
    return data;
  }
}
