import 'package:tencent_im_plugin/entity/group_at_info_entity.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/enums/conversation_type_enum.dart';
import 'package:tencent_im_plugin/enums/group_receive_message_opt_enum.dart';
import 'package:tencent_im_plugin/enums/group_type_enum.dart';
import 'package:tencent_im_plugin/list_util.dart';
import 'dart:convert';

/// 会话实体
class ConversationEntity {
  /// 会话ID
  late String conversationID;

  /// 会话类型
  late ConversationTypeEnum type;

  /// 用户ID
  String? userID;

  /// 群ID
  String? groupID;

  /// 显示名称
  String? showName;

  /// 头像
  String? faceUrl;

  /// 接收消息选项（群会话有效）
  GroupReceiveMessageOptEnum? recvOpt;

  /// 群类型
  GroupTypeEnum? groupType;

  /// 未读数量
  int? unreadCount;

  /// 最后一条消息
  MessageEntity? lastMessage;

  /// 草稿文本
  String? draftText;

  /// 草稿时间
  int? draftTimestamp;

  /// @信息列表
  List<GroupAtInfoEntity>? groupAtInfoList;

  ConversationEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['conversationID'] != null) conversationID = json['conversationID'];
    if (json['type'] != null)
      type = ConversationTypeTool.getByInt(json['type']);
    if (json['userID'] != null) userID = json['userID'];
    if (json['groupID'] != null) groupID = json['groupID'];
    if (json['showName'] != null) showName = json['showName'];
    if (json['faceUrl'] != null) faceUrl = json['faceUrl'];
    if (json['recvOpt'] != null)
      recvOpt = GroupReceiveMessageOptTool.getByInt(json['recvOpt']);
    if (json['groupType'] != null)
      groupType = GroupTypeTool.getByString(json['groupType']);
    if (json['unreadCount'] != null) unreadCount = json['unreadCount'];
    if (json['lastMessage'] != null)
      lastMessage = MessageEntity.fromJson(json["lastMessage"]);
    if (json['draftText'] != null) draftText = json['draftText'];
    if (json['draftTimestamp'] != null) draftTimestamp = json['draftTimestamp'];
    if (json['groupAtInfoList'] != null)
      groupAtInfoList =
          ListUtil.generateOBJList<GroupAtInfoEntity>(json["groupAtInfoList"]);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationEntity &&
          runtimeType == other.runtimeType &&
          conversationID == other.conversationID;

  @override
  int get hashCode => conversationID.hashCode;
}
