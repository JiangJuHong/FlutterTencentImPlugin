import 'dart:convert';

import 'package:tencent_im_plugin/entity/user_info_entity.dart';

import 'node_entity.dart';

/// 消息实体
class MessageEntity {
  // 随机码
  int rand;

  // 自定义整数
  int customInt;

  // 自定义值
  String customStr;

  // 是否已读
  bool read;

  // 节点列表
  List<NodeEntity> elemList;

  // 当前登录用户是否是发送方
  bool self;

  // 消息id
  String id;

  // 消息唯一id
  int uniqueId;

  // 序列号
  int seq;

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

  MessageEntity({
    this.rand,
    this.customInt,
    this.read,
    this.elemList,
    this.self,
    this.id,
    this.uniqueId,
    this.seq,
    this.customStr,
    this.timestamp,
    this.peerReaded,
    this.sender,
    this.sessionId,
    this.userInfo,
  });

  MessageEntity.fromJson(Map<String, dynamic> json) {
    rand = json['rand'];
    customInt = json['customInt'];
    read = json['read'];
    if (json['elemList'] != null) {
      List<NodeEntity> entitys = [];
      for (var item in json['elemList']) {
        entitys.add(NodeEntity.getEntity(item));
      }
      elemList = entitys;
    }
    self = json['self'];
    id = json['id'];
    uniqueId = json['uniqueId'];
    seq = json['seq'];
    customStr = json['customStr'];
    timestamp = json['timestamp'];
    peerReaded = json['peerReaded'];
    sender = json['sender'];
    sessionId = json['sessionId'];
    userInfo = json['userInfo'] == null
        ? null
        : UserInfoEntity.fromJson(json['userInfo']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rand'] = this.rand;
    data['customInt'] = this.customInt;
    data['read'] = this.read;
    if (this.elemList != null) {
      data['elemList'] = elemList == null ? null : jsonEncode(elemList);
    }
    data['self'] = this.self;
    data['id'] = this.id;
    data['uniqueId'] = this.uniqueId;
    data['seq'] = this.seq;
    data['customStr'] = this.customStr;
    data['timestamp'] = this.timestamp;
    data['peerReaded'] = this.peerReaded;
    data['sender'] = this.sender;
    data['sessionId'] = this.sessionId;
    data['userInfo'] = this.userInfo == null ? null : this.userInfo.toJson();
    return data;
  }
}
