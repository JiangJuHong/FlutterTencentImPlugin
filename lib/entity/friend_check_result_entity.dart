import 'dart:convert';
import 'package:tencent_im_plugin/enums/friend_relation_type_enum.dart';

/// 好友检测结果实体
class FriendCheckResultEntity {
  /// 好友 id
  String userID;

  /// 返回结果码
  int resultCode;

  /// 返回结果描述
  String resultInfo;

  /// 好友结果类型
  FriendRelationTypeEnum resultType;

  FriendCheckResultEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    userID = json['userID'];
    resultCode = json['resultCode'];
    resultInfo = json['resultInfo'];
    resultType = FriendRelationTypeTool.getByInt(json['resultType']);
  }
}
