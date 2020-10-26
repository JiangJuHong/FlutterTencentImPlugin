import 'package:tencent_im_plugin/enums/signaling_action_type_enum.dart';

/// 信令信息实体
class SignalingInfoEntity {
  String inviteID;
  String groupID;
  String inviter;
  List<String> inviteeList;
  String data;
  int timeout;
  SignalingActionTypeEnum actionType;
  int businessID;
  bool onlineUserOnly;

  SignalingInfoEntity.fromJson(Map<String, dynamic> json) {
    inviteID = json["inviteID"];
    groupID = json["groupID"];
    inviter = json["inviter"];
    inviteeList = json["inviteeList"];
    data = json["data"];
    timeout = json["timeout"];
    if (json["actionType"] != null) actionType = SignalingActionTypeTool.getByInt(json["actionType"]);
    businessID = json["businessID"];
    onlineUserOnly = json["onlineUserOnly"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.inviteID != null) data['inviteID'] = this.inviteID;
    if (this.groupID != null) data['groupID'] = this.groupID;
    if (this.inviter != null) data['inviter'] = this.inviter;
    if (this.inviteeList != null) data['inviteeList'] = this.inviteeList;
    if (this.data != null) data['data'] = this.data;
    if (this.timeout != null) data['timeout'] = this.timeout;
    if (this.actionType != null) data['actionType'] = SignalingActionTypeTool.toInt(this.actionType);
    if (this.businessID != null) data['businessID'] = this.businessID;
    if (this.onlineUserOnly != null) data['onlineUserOnly'] = this.onlineUserOnly;
    return data;
  }
}
