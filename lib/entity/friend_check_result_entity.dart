import 'dart:convert';
import 'package:tencent_im_plugin/enums/friend_relation_type_enum.dart';

/// 好友检测结果实体
class FriendCheckResultEntity {
  /// 好友 id
  late String userID;

  /// 返回结果码
  late int resultCode;

  /// 返回结果描述
  String? resultInfo;

  /// 好友结果类型
  FriendRelationTypeEnum? resultType;

  FriendCheckResultEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['userID'] != null) userID = json['userID'];
    if (json['resultCode'] != null) resultCode = json['resultCode'];
    if (json['resultInfo'] != null) resultInfo = json['resultInfo'];
    if (json['resultType'] != null)
      resultType = FriendRelationTypeTool.getByInt(json['resultType']);
  }
}
