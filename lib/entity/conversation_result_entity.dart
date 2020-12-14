import 'dart:convert';

import 'package:tencent_im_plugin/entity/conversation_entity.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 会话结果实体
class ConversationResultEntity {
  /// 下一次分页拉取的游标
  int nextSeq;

  /// 会话列表是否已经拉取完毕
  bool finished;

  /// 会话列表
  List<ConversationEntity> conversationList;

  ConversationResultEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);

    nextSeq = json['nextSeq'];
    finished = json['finished'];
    conversationList =
        ListUtil.generateOBJList<ConversationEntity>(json["conversationList"]);
  }
}
