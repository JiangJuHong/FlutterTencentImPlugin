import 'dart:convert';
import 'package:tencent_im_plugin/entity/friend_application_entity.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 好友申请结果实体
class FriendApplicationResultEntity {
  /// 未读数量
  int unreadCount;

  /// 好友申请列表
  List<FriendApplicationEntity> friendApplicationList;

  FriendApplicationResultEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    unreadCount = json['unreadCount'];
    friendApplicationList = ListUtil.generateOBJList<FriendApplicationEntity>(
        json['friendApplicationList']);
  }
}
