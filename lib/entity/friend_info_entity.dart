import 'dart:convert';
import 'package:tencent_im_plugin/entity/user_entity.dart';

/// 好友信息实体
class FriendInfoEntity {
  /// 用户ID
  late String userID;

  /// 好友备注
  String? friendRemark;

  /// 好友分组列表
  List<String>? friendGroups;

  /// 好友自定义信息
  Map<String, String>? friendCustomInfo;

  /// 用户信息
  UserEntity? userProfile;

  FriendInfoEntity({
    required this.userID,
    this.friendRemark,
    this.friendCustomInfo,
  });

  FriendInfoEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['userID'] != null) userID = json['userID'];
    if (json['friendRemark'] != null) friendRemark = json['friendRemark'];
    if (json['friendGroups'] != null)
      friendGroups = json['friendGroups']?.cast<String>();
    if (json['friendCustomInfo'] != null)
      friendCustomInfo = json['friendCustomInfo']?.cast<String, String>();
    if (json['userProfile'] != null)
      userProfile = UserEntity.fromJson(json['userProfile']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    if (this.friendRemark != null) data['friendRemark'] = this.friendRemark;
    if (this.friendCustomInfo != null)
      data['friendCustomInfo'] = this.friendCustomInfo;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FriendInfoEntity &&
          runtimeType == other.runtimeType &&
          userID == other.userID;

  @override
  int get hashCode => userID.hashCode;
}
