import 'dart:convert';
import 'package:tencent_im_plugin/entity/friend_info_entity.dart';
import 'package:tencent_im_plugin/enums/friend_relation_type_enum.dart';
import 'package:tencent_im_plugin/enums/friend_type_enum.dart';

/// 好友信息结果实体
class FriendInfoResultEntity {
  /// 结果码
  int resultCode;

  /// 结果信息`
  String resultInfo;

  /// 好友类型
  FriendRelationTypeEnum relation;

  /// 好友信息
  FriendInfoEntity friendInfo;

  FriendInfoResultEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    resultCode = json['resultCode'];
    resultInfo = json['resultInfo'];
    relation = FriendRelationTypeTool.getByInt(json['relation']);
    friendInfo = FriendInfoEntity.fromJson(json['friendInfo']);
  }
}
