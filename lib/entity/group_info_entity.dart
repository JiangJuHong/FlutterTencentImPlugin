import 'dart:convert';
import 'package:tencent_im_plugin/enums/group_add_opt_enum.dart';
import 'package:tencent_im_plugin/enums/group_member_role_enum.dart';
import 'package:tencent_im_plugin/enums/group_receive_message_opt_enum.dart';
import 'package:tencent_im_plugin/enums/group_type_enum.dart';

/// 群实体
class GroupInfoEntity {
  /// 群ID
  String groupID;

  /// 群类型
  GroupTypeEnum groupType;

  /// 群名称
  String groupName;

  /// 群公告
  String notification;

  /// 群简介
  String introduction;

  /// 群头像
  String faceUrl;

  /// 是否设置了全员禁言
  bool allMuted;

  /// 群主ID
  String owner;

  /// 创建时间
  int createTime;

  /// 加群审批类型。
  GroupAddOptEnum groupAddOpt;

  /// 群最近一次群资料修改时间
  int lastInfoTime;

  /// 群最近一次发消息时间
  int lastMessageTime;

  /// 群成员总数量
  int memberCount;

  /// 在线成员数量
  int onlineCount;

  /// 群成员角色
  GroupMemberRoleEnum role;

  /// 当前用户在此群组中的消息接收选项
  GroupReceiveMessageOptEnum recvOpt;

  /// 当前用户在此群中的加入时间
  int joinTime;

  /// 自定义字段
  Map<String, String> customInfo;

  GroupInfoEntity({
    this.groupID,
    this.groupType,
    this.groupName,
    this.notification,
    this.introduction,
    this.faceUrl,
    this.allMuted,
    this.groupAddOpt,
    this.customInfo,
  });

  GroupInfoEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    groupID = json['groupID'];
    groupType = GroupTypeTool.getByString(json["groupType"]);
    groupName = json['groupName'];
    notification = json['notification'];
    introduction = json['introduction'];
    faceUrl = json['faceUrl'];
    allMuted = json['allMuted'];
    owner = json['owner'];
    createTime = json['createTime'];
    groupAddOpt = GroupAddOptTool.getByInt(json["groupAddOpt"]);
    lastInfoTime = json['lastInfoTime'];
    lastMessageTime = json['lastMessageTime'];
    memberCount = json['memberCount'];
    onlineCount = json['onlineCount'];
    role = GroupMemberRoleTool.getByInt(json["role"]);
    recvOpt = GroupReceiveMessageOptTool.getByInt(json["recvOpt"]);
    joinTime = json['joinTime'];
    if (json['customInfo'] != null)
      customInfo = (json['customInfo'] as Map).cast<String, String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.groupID != null) data['groupID'] = this.groupID;
    if (this.groupType != null)
      data['groupType'] = GroupTypeTool.toTypeString(this.groupType);
    if (this.groupName != null) data['groupName'] = this.groupName;
    if (this.notification != null) data['notification'] = this.notification;
    if (this.introduction != null) data['introduction'] = this.introduction;
    if (this.faceUrl != null) data['faceUrl'] = this.faceUrl;
    if (this.allMuted != null) data['allMuted'] = this.allMuted;
    if (this.groupAddOpt != null)
      data['groupAddOpt'] = GroupAddOptTool.toInt(this.groupAddOpt);
    if (this.customInfo != null) data['customInfo'] = this.customInfo;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupInfoEntity &&
          runtimeType == other.runtimeType &&
          groupID == other.groupID;

  @override
  int get hashCode => groupID.hashCode;
}
