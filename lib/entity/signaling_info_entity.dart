import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tencent_im_plugin/entity/offline_push_info_entity.dart';
import 'package:tencent_im_plugin/enums/signaling_action_type_enum.dart';
import 'package:uuid/uuid.dart';

/// 信令信息实体
class SignalingInfoEntity {
  /// 邀请ID
  String inviteID;

  /// 群ID
  String groupID;

  /// 邀请人
  String inviter;

  /// 被邀请人
  List<String> inviteeList;

  /// 数据
  String data;

  /// 超时
  int timeout;

  /// 类型
  SignalingActionTypeEnum actionType;

  /// ID
  int businessID;

  /// 是否仅在线用户
  bool onlineUserOnly;

  /// 离线推送信息
  OfflinePushInfoEntity offlinePushInfo;

  SignalingInfoEntity({
    this.inviteID,
    this.groupID,
    @required this.inviter,
    @required this.inviteeList,
    @required this.data,
    this.timeout: 0,
    @required this.actionType,
    this.businessID: 0,
    this.onlineUserOnly: false,
  });

  SignalingInfoEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    inviteID = json["inviteID"];
    groupID = json["groupID"];
    inviter = json["inviter"];
    inviteeList = json["inviteeList"];
    data = json["data"];
    timeout = json["timeout"];
    if (json["actionType"] != null)
      actionType = SignalingActionTypeTool.getByInt(json["actionType"]);
    businessID = json["businessID"];
    onlineUserOnly = json["onlineUserOnly"];
    if (json["offlinePushInfo"] != null)
      offlinePushInfo = OfflinePushInfoEntity.fromJson(json["offlinePushInfo"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inviteID'] = this.inviteID ?? Uuid().v4().toString();
    if (this.groupID != null) data['groupID'] = this.groupID;
    if (this.inviter != null) data['inviter'] = this.inviter;
    if (this.inviteeList != null) data['inviteeList'] = this.inviteeList;
    if (this.data != null) data['data'] = this.data;
    if (this.timeout != null) data['timeout'] = this.timeout;
    if (this.actionType != null)
      data['actionType'] = SignalingActionTypeTool.toInt(this.actionType);
    if (this.businessID != null) data['businessID'] = this.businessID;
    if (this.onlineUserOnly != null)
      data['onlineUserOnly'] = this.onlineUserOnly;
    return data;
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is SignalingInfoEntity && runtimeType == other.runtimeType && inviteID == other.inviteID;

  @override
  int get hashCode => inviteID.hashCode;
}
