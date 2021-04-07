import 'dart:convert';

/// 信令通用实体
class SignalingCommonEntity {
  /// 邀请ID
  late String inviteID;

  /// 邀请人
  String? inviter;

  /// 被邀请人
  String? invitee;

  /// 被邀请人列表
  List<String>? inviteeList;

  /// 消息内容
  String? data;

  SignalingCommonEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['inviteID'] != null) inviteID = json["inviteID"];
    if (json['inviter'] != null) inviter = json["inviter"];
    if (json['invitee'] != null) invitee = json["invitee"];
    if (json['inviteeList'] != null)
      inviteeList = json["inviteeList"]?.cast<String>();
    if (json['data'] != null) this.data = json["data"];
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignalingCommonEntity &&
          runtimeType == other.runtimeType &&
          inviteID == other.inviteID;

  @override
  int get hashCode => inviteID.hashCode;
}
