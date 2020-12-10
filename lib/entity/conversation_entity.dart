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
  String conversationID;

  /// 会话类型
  ConversationTypeEnum type;

  /// 用户ID
  String userID;

  /// 群ID
  String groupID;

  /// 显示名称
  String showName;

  /// 头像
  String faceUrl;

  /// 接收消息选项（群会话有效）
  GroupReceiveMessageOptEnum recvOpt;

  /// 群类型
  GroupTypeEnum groupType;

  /// 未读数量
  int unreadCount;

  /// 最后一条消息
  MessageEntity lastMessage;

  /// 草稿文本
  String draftText;

  /// 草稿时间
  int draftTimestamp;

  /// @信息列表
  List<GroupAtInfoEntity> groupAtInfoList;

  ConversationEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    conversationID = json['conversationID'];
    type = ConversationTypeTool.getByInt(json['type']);
    userID = json['userID'];
    groupID = json['groupID'];
    showName = json['showName'];
    faceUrl = json['faceUrl'];
    recvOpt = GroupReceiveMessageOptTool.getByInt(json['recvOpt']);
    groupType = GroupTypeTool.getByString(json['groupType']);
    unreadCount = json['unreadCount'];
    lastMessage = json['lastMessage'] == null
        ? null
        : MessageEntity.fromJson(json["lastMessage"]);
    draftText = json['draftText'];
    draftTimestamp = json['draftTimestamp'];
    groupAtInfoList = json["groupAtInfoList"] == null
        ? null
        : ListUtil.generateOBJList<GroupAtInfoEntity>(json["groupAtInfoList"]);
  }
}
