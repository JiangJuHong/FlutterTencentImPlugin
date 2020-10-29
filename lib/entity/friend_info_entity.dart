import 'package:tencent_im_plugin/entity/user_entity.dart';

/// 好友信息实体
class FriendInfoEntity {
  /// 用户ID
  String userID;

  /// 好友备注
  String friendRemark;

  /// 好友分组列表
  List<String> friendGroups;

  /// 好友自定义信息
  Map<String, String> friendCustomInfo;

  /// 用户信息
  UserEntity userProfile;

  FriendInfoEntity.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    friendRemark = json['friendRemark'];
    friendGroups = json['friendGroups'];
    friendCustomInfo = json['friendCustomInfo'];
    userProfile = UserEntity.fromJson(json['userProfile']);
  }
}
