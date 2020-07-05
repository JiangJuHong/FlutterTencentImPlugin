import 'package:tencent_im_plugin/entity/session_entity.dart';
import 'package:tencent_im_plugin/entity/user_info_entity.dart';
import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/enums/message_status_enum.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';
import 'package:tencent_im_plugin/utils/enum_util.dart';

/// 消息实体
class MessageEntity {
  // 自定义整数
  int customInt;

  // 消息随机码
  int rand;

  // 消息序列号
  int seq;

  // 自定义值
  String customStr;

  // 是否已读
  bool read;

  // 节点列表
  List<MessageNode> elemList;

  // 当前登录用户是否是发送方
  bool self;

  // 消息id
  String id;

  // 消息唯一id
  int uniqueId;

  // 时间戳
  int timestamp;

  // 对方是否已读
  bool peerReaded;

  // 消息发送方
  String sender;

  // 会话ID
  String sessionId;

  // 用户信息
  UserInfoEntity userInfo;

  // 状态(只读字段)
  MessageStatusEnum status;

  // 会话类型
  SessionType sessionType;

  // 描述
  String note;

  MessageEntity({
    this.customInt,
    this.read,
    this.elemList,
    this.self,
    this.id,
    this.uniqueId,
    this.customStr,
    this.timestamp,
    this.peerReaded,
    this.sender,
    this.sessionId,
    this.userInfo,
    this.sessionType,
    this.rand,
    this.seq,
    this.note,
  });

  MessageEntity.fromJson(Map<String, dynamic> json) {
    customInt = json['customInt'];
    read = json['read'];
    if (json['elemList'] != null) {
      elemList = [];
      for (var item in json['elemList']) {
        elemList.add(
          MessageNodeTypeUtil.getMessageNodeByMessageNodeType(
            EnumUtil.nameOf(MessageNodeType.values, item["nodeType"]),
            item,
          ),
        );
      }
    }
    self = json['self'];
    id = json['id'];
    uniqueId = json['uniqueId'];
    customStr = json['customStr'];
    timestamp = json['timestamp'];
    peerReaded = json['peerReaded'];
    sender = json['sender'];
    sessionId = json['sessionId'];
    userInfo = json['userInfo'] == null
        ? null
        : UserInfoEntity.fromJson(json['userInfo']);
    if (json['status'] != null) {
      for (var item in MessageStatusEnum.values) {
        if (EnumUtil.getEnumName(item) == json['status']) {
          status = item;
          break;
        }
      }
    }
    for (var item in SessionType.values) {
      if (EnumUtil.getEnumName(item) == json['sessionType']) {
        sessionType = item;
      }
    }
    rand = json['rand'];
    seq = json['seq'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customInt'] = this.customInt;
    data['read'] = this.read;
    // elemList 节点不需要反序列化到后台
//    if (this.elemList != null) {
//      data['elemList'] = elemList == null ? null : jsonEncode(elemList);
//    }
    data['self'] = this.self;
    data['id'] = this.id;
    data['uniqueId'] = this.uniqueId;
    data['customStr'] = this.customStr;
    data['timestamp'] = this.timestamp;
    data['peerReaded'] = this.peerReaded;
    data['sender'] = this.sender;
    data['sessionId'] = this.sessionId;
    data['sessionType'] = EnumUtil.getEnumName(this.sessionType);
    data['userInfo'] = this.userInfo == null ? null : this.userInfo.toJson();

    data['status'] =
        this.status == null ? null : EnumUtil.getEnumName(this.status);
    data['rand'] = this.rand;
    data['seq'] = this.seq;
    data['note'] = this.note;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageEntity &&
          runtimeType == other.runtimeType &&
          rand == other.rand &&
          seq == other.seq &&
          self == other.self &&
          sessionId == other.sessionId;

  @override
  int get hashCode =>
      rand.hashCode ^ seq.hashCode ^ self.hashCode ^ sessionId.hashCode;
}
