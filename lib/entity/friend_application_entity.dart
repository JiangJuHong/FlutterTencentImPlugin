import 'dart:convert';
import 'package:tencent_im_plugin/enums/friend_application_type_enum.dart';

/// 好友申请实体
class FriendApplicationEntity {
  /// 用户ID
  late String userID;

  /// 用户昵称
  String? nickname;

  /// 用户头像
  String? faceUrl;

  /// 申请时间
  late int addTime;

  /// 申请来源
  String? addSource;

  /// 申请描述
  String? addWording;

  /// 类型
  late FriendApplicationTypeEnum type;

  FriendApplicationEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['userID'] != null) userID = json['userID'];
    if (json['nickname'] != null) nickname = json['nickname'];
    if (json['faceUrl'] != null) faceUrl = json['faceUrl'];
    if (json['addTime'] != null) addTime = json['addTime'];
    if (json['addSource'] != null) addSource = json['addSource'];
    if (json['addWording'] != null) addWording = json['addWording'];
    if (json['type'] != null)
      type = FriendApplicationTypeTool.getByInt(json['type']);
  }
}
