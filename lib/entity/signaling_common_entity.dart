/// 信令通用实体
class SignalingCommonEntity {
  /// 邀请ID
  String inviteID;

  /// 邀请人
  String inviter;

  /// 被邀请人
  String invitee;

  /// 被邀请人列表
  List<String> inviteeList;

  /// 消息内容
  String data;

  SignalingCommonEntity.fromJson(Map<String, dynamic> json) {
    inviteID = json["inviteID"];
    inviter = json["inviter"];
    invitee = json["invitee"];
    inviteeList = json["inviteeList"]?.cast<String>();
    data = json["data"];
  }
}
