import 'dart:convert';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群成员信息结果实体
class GroupMemberInfoResultEntity {
  /// 获取分页拉取的 seq。如果为 0 表示拉取结束。
  int nextSeq;

  /// 群信息
  List<GroupMemberEntity> memberInfoList;

  GroupMemberInfoResultEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    nextSeq = json['nextSeq'];
    memberInfoList =
        ListUtil.generateOBJList<GroupMemberEntity>(json['memberInfoList']);
  }
}
