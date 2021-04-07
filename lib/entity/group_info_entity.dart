import 'dart:convert';
import 'package:tencent_im_plugin/enums/group_add_opt_enum.dart';
import 'package:tencent_im_plugin/enums/group_member_role_enum.dart';
import 'package:tencent_im_plugin/enums/group_receive_message_opt_enum.dart';
import 'package:tencent_im_plugin/enums/group_type_enum.dart';

/// 群实体
class GroupInfoEntity {
  /// 群ID
  late String groupID;

  /// 群类型
  GroupTypeEnum? groupType;

  /// 群名称
  String? groupName;

  /// 群公告
  String? notification;

  /// 群简介
  String? introduction;

  /// 群头像
  String? faceUrl;

  /// 是否设置了全员禁言
  bool? allMuted;

  /// 群主ID
  String? owner;

  /// 创建时间
  int? createTime;

  /// 加群审批类型。
  GroupAddOptEnum? groupAddOpt;

  /// 群最近一次群资料修改时间
  int? lastInfoTime;

  /// 群最近一次发消息时间
  int? lastMessageTime;

  /// 群成员总数量
  int? memberCount;

  /// 在线成员数量
  int? onlineCount;

  /// 群成员角色
  GroupMemberRoleEnum? role;

  /// 当前用户在此群组中的消息接收选项
  GroupReceiveMessageOptEnum? recvOpt;

  /// 当前用户在此群中的加入时间
  int? joinTime;

  /// 自定义字段
  Map<String, String>? customInfo;

  GroupInfoEntity({
    required this.groupID,
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
    if (json['groupID'] != null) groupID = json['groupID'];
    if (json['groupType'] != null)
      groupType = GroupTypeTool.getByString(json["groupType"]);
    if (json['groupName'] != null) groupName = json['groupName'];
    if (json['notification'] != null) notification = json['notification'];
    if (json['introduction'] != null) introduction = json['introduction'];
    if (json['faceUrl'] != null) faceUrl = json['faceUrl'];
    if (json['allMuted'] != null) allMuted = json['allMuted'];
    if (json['owner'] != null) owner = json['owner'];
    if (json['createTime'] != null) createTime = json['createTime'];
    if (json['groupAddOpt'] != null)
      groupAddOpt = GroupAddOptTool.getByInt(json["groupAddOpt"]);
    if (json['lastInfoTime'] != null) lastInfoTime = json['lastInfoTime'];
    if (json['lastMessageTime'] != null)
      lastMessageTime = json['lastMessageTime'];
    if (json['memberCount'] != null) memberCount = json['memberCount'];
    if (json['onlineCount'] != null) onlineCount = json['onlineCount'];
    if (json['role'] != null) role = GroupMemberRoleTool.getByInt(json["role"]);
    if (json['recvOpt'] != null)
      recvOpt = GroupReceiveMessageOptTool.getByInt(json["recvOpt"]);
    if (json['joinTime'] != null) joinTime = json['joinTime'];
    if (json['customInfo'] != null)
      customInfo = (json['customInfo'] as Map).cast<String, String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupID'] = this.groupID;
    if (this.groupType != null)
      data['groupType'] = GroupTypeTool.toTypeString(this.groupType!);
    if (this.groupName != null) data['groupName'] = this.groupName;
    if (this.notification != null) data['notification'] = this.notification;
    if (this.introduction != null) data['introduction'] = this.introduction;
    if (this.faceUrl != null) data['faceUrl'] = this.faceUrl;
    if (this.allMuted != null) data['allMuted'] = this.allMuted;
    if (this.groupAddOpt != null)
      data['groupAddOpt'] = GroupAddOptTool.toInt(this.groupAddOpt!);
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
