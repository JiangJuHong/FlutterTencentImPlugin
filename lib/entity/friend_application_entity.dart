import 'dart:convert';
import 'package:tencent_im_plugin/enums/friend_application_type_enum.dart';

/// 好友申请实体
class FriendApplicationEntity {
  /// 用户ID
  String userID;

  /// 用户昵称
  String nickname;

  /// 用户头像
  String faceUrl;

  /// 申请时间
  int addTime;

  /// 申请来源
  String addSource;

  /// 申请描述
  String addWording;

  /// 类型
  FriendApplicationTypeEnum type;

  FriendApplicationEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    userID = json['userID'];
    nickname = json['nickname'];
    faceUrl = json['faceUrl'];
    addTime = json['addTime'];
    addSource = json['addSource'];
    addWording = json['addWording'];
    type = FriendApplicationTypeTool.getByInt(json['type']);
  }
}
