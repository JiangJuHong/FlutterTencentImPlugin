import 'dart:convert';
import 'package:tencent_im_plugin/entity/friend_info_entity.dart';
import 'package:tencent_im_plugin/enums/friend_relation_type_enum.dart';

/// 好友信息结果实体
class FriendInfoResultEntity {
  /// 结果码
  late int resultCode;

  /// 结果信息`
  String? resultInfo;

  /// 好友类型
  FriendRelationTypeEnum? relation;

  /// 好友信息
  FriendInfoEntity? friendInfo;

  FriendInfoResultEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['resultCode'] != null) resultCode = json['resultCode'];
    if (json['resultInfo'] != null) resultInfo = json['resultInfo'];
    if (json['relation'] != null)
      relation = FriendRelationTypeTool.getByInt(json['relation']);
    if (json['friendInfo'] != null)
      friendInfo = FriendInfoEntity.fromJson(json['friendInfo']);
  }
}
