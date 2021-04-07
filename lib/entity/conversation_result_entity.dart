import 'dart:convert';

import 'package:tencent_im_plugin/entity/conversation_entity.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 会话结果实体
class ConversationResultEntity {
  /// 下一次分页拉取的游标
  late int nextSeq;

  /// 会话列表是否已经拉取完毕
  late bool finished;

  /// 会话列表
  late List<ConversationEntity> conversationList;

  ConversationResultEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['nextSeq'] != null) nextSeq = json['nextSeq'];
    if (json['finished'] != null) finished = json['finished'];
    if (json['conversationList'] != null)
      conversationList = ListUtil.generateOBJList<ConversationEntity>(
          json["conversationList"]);
  }
}
