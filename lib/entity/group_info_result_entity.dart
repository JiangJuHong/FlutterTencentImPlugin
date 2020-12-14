import 'dart:convert';
import 'package:tencent_im_plugin/entity/group_info_entity.dart';

/// 群信息结果实体
class GroupInfoResultEntity {
  /// 返回码，0代表成功，非零代表失败
  int resultCode;

  /// 返回消息描述
  String resultMessage;

  /// 群信息
  GroupInfoEntity groupInfo;

  GroupInfoResultEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    resultCode = json['resultCode'];
    resultMessage = json['resultMessage'];
    groupInfo = GroupInfoEntity.fromJson(json['groupInfo']);
  }
}
