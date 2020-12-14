import 'dart:convert';
import 'package:tencent_im_plugin/entity/offline_push_info_entity.dart';
import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/enums/message_priority_enum.dart';
import 'package:tencent_im_plugin/enums/message_status_enum.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 消息实体
class MessageEntity {
  /// 消息 ID
  String msgID;

  /// 消息时间戳
  int timestamp;

  /// 消息发送者 userID
  String sender;

  /// 消息发送者昵称
  String nickName;

  /// 好友备注。如果没有拉取过好友信息或者不是好友，返回 null
  String friendRemark;

  /// 发送者头像 url
  String faceUrl;

  /// 群组消息，nameCard 为发送者的群名片
  String nameCard;

  /// 群组消息，groupID 为接收消息的群组 ID，否则为 null
  String groupID;

  /// 单聊消息，userID 为会话用户 ID，否则为 null。 假设自己和 userA 聊天，无论是自己发给 userA 的消息还是 userA 发给自己的消息，这里的 userID 均为 userA
  String userID;

  /// 消息发送状态
  MessageStatusEnum status;

  /// 消息类型
  MessageElemTypeEnum elemType;

  /// 消息自定义数据（本地保存，不会发送到对端，程序卸载重装后失效）
  String localCustomData;

  /// 消息自定义数据（本地保存，不会发送到对端，程序卸载重装后失效）
  int localCustomInt;

  /// 消息发送者是否是自己
  bool self;

  /// 消息自己是否已读
  bool read;

  /// 消息对方是否已读（只有 C2C 消息有效）
  bool peerRead;

  /// 消息优先级
  MessagePriorityEnum priority;

  /// 消息的离线推送信息
  OfflinePushInfoEntity offlinePushInfo;

  /// 群@用户列表
  List<String> groupAtUserList;

  /// 消息的序列号
  /// 群聊中的消息序列号云端生成，在群里是严格递增且唯一的。 单聊中的序列号是本地生成，不能保证严格递增且唯一。
  int seq;

  /// 描述信息，描述当前消息，可直接用于显示
  String note;

  /// 消息节点信息
  MessageNode node;

  MessageEntity({
    this.msgID,
    this.timestamp,
    this.sender,
    this.nickName,
    this.friendRemark,
    this.faceUrl,
    this.nameCard,
    this.groupID,
    this.userID,
    this.status,
    this.elemType,
    this.localCustomData,
    this.localCustomInt,
    this.self: true,
    this.read: true,
    this.peerRead: false,
    this.priority,
    this.offlinePushInfo,
    this.groupAtUserList,
    this.seq,
    this.note,
    this.node,
  });

  MessageEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    msgID = json["msgID"];
    timestamp = json["timestamp"];
    sender = json["sender"];
    nickName = json["nickName"];
    friendRemark = json["friendRemark"];
    faceUrl = json["faceUrl"];
    nameCard = json["nameCard"];
    groupID = json["groupID"];
    userID = json["userID"];
    if (json["status"] != null)
      status = MessageStatusTool.getByInt(json["status"]);
    if (json["elemType"] != null)
      elemType = MessageElemTypeTool.getByInt(json["elemType"]);
    localCustomData = json["localCustomData"];
    localCustomInt = json["localCustomInt"];
    if (json["self"] != null) self = json["self"];
    if (json["read"] != null) read = json["read"];
    if (json["peerRead"] != null) peerRead = json["peerRead"];
    if (json["priority"] != null)
      priority = MessagePriorityTool.getByInt(json["priority"]);
    if (json["offlinePushInfo"] != null)
      offlinePushInfo = OfflinePushInfoEntity.fromJson(json["offlinePushInfo"]);
    groupAtUserList = json["groupAtUserList"]?.cast<String>();
    seq = json["seq"];
    note = json["note"];
    node = json["node"] == null
        ? null
        : MessageElemTypeTool.getMessageNodeByMessageNodeType(
            elemType, json["node"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.msgID != null) data['msgID'] = this.msgID;
    if (this.timestamp != null) data['timestamp'] = this.timestamp;
    if (this.sender != null) data['sender'] = this.sender;
    if (this.nickName != null) data['nickName'] = this.nickName;
    if (this.friendRemark != null) data['friendRemark'] = this.friendRemark;
    if (this.faceUrl != null) data['faceUrl'] = this.faceUrl;
    if (this.nameCard != null) data['nameCard'] = this.nameCard;
    if (this.groupID != null) data['groupID'] = this.groupID;
    if (this.userID != null) data['userID'] = this.userID;
    if (this.status != null)
      data['status'] = MessageStatusTool.toInt(this.status);
    if (this.elemType != null)
      data['elemType'] = MessageElemTypeTool.toInt(this.elemType);
    if (this.localCustomData != null)
      data['localCustomData'] = this.localCustomData;
    if (this.localCustomInt != null)
      data['localCustomInt'] = this.localCustomInt;
    if (this.self != null) data['self'] = this.self;
    if (this.read != null) data['read'] = this.read;
    if (this.peerRead != null) data['peerRead'] = this.peerRead;
    if (this.priority != null)
      data['priority'] = MessagePriorityTool.toInt(this.priority);
    if (this.offlinePushInfo != null)
      data['offlinePushInfo'] = this.offlinePushInfo.toJson();
    if (this.groupAtUserList != null)
      data['groupAtUserList'] = this.groupAtUserList;
    if (this.seq != null) data['seq'] = this.seq;
    if (this.note != null) data['note'] = this.note;
    return data;
  }
}
