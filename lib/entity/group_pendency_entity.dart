import 'package:tencent_im_plugin/entity/group_info_entity.dart';
import 'package:tencent_im_plugin/entity/user_info_entity.dart';

class GroupPendencyEntity {
  String toUser;
  String identifier;
  int addTime;
  String fromUser;
  String pendencyType;
  String groupId;
  String requestMsg;
  String handledMsg;
  String handledStatus;
  String operationType;
  UserInfoEntity applyUserInfo;
  UserInfoEntity handlerUserInfo;
  GroupInfoEntity groupInfo;

  GroupPendencyEntity({
    this.toUser,
    this.identifier,
    this.addTime,
    this.fromUser,
    this.pendencyType,
    this.groupId,
    this.requestMsg,
    this.handledMsg,
    this.handledStatus,
    this.operationType,
    this.applyUserInfo,
    this.handlerUserInfo,
    this.groupInfo,
  });

  GroupPendencyEntity.fromJson(Map<String, dynamic> json) {
    toUser = json['toUser'];
    identifier = json['identifier'];
    addTime = json['addTime'];
    fromUser = json['fromUser'];
    pendencyType = json['pendencyType'];
    groupId = json['groupId'];
    requestMsg = json['requestMsg'];
    handledMsg = json['handledMsg'];
    handledStatus = json['handledStatus'];
    operationType = json['operationType'];
    applyUserInfo = json['applyUserInfo'] != null
        ? new UserInfoEntity.fromJson(json['applyUserInfo'])
        : null;
    handlerUserInfo = json['handlerUserInfo'] != null
        ? new UserInfoEntity.fromJson(json['handlerUserInfo'])
        : null;
    groupInfo = json['groupInfo'] != null
        ? new GroupInfoEntity.fromJson(json['groupInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toUser'] = this.toUser;
    data['identifier'] = this.identifier;
    data['addTime'] = this.addTime;
    data['fromUser'] = this.fromUser;
    data['pendencyType'] = this.pendencyType;
    data['groupId'] = this.groupId;
    data['requestMsg'] = this.requestMsg;
    data['handledMsg'] = this.handledMsg;
    data['handledStatus'] = this.handledStatus;
    data['operationType'] = this.operationType;
    if (this.applyUserInfo != null) {
      data['applyUserInfo'] = this.applyUserInfo.toJson();
    }
    if (this.handlerUserInfo != null) {
      data['handlerUserInfo'] = this.handlerUserInfo.toJson();
    }
    if (this.groupInfo != null) {
      data['groupInfo'] = this.groupInfo.toJson();
    }
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupPendencyEntity &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier &&
          fromUser == other.fromUser;

  @override
  int get hashCode => identifier.hashCode ^ fromUser.hashCode;
}
