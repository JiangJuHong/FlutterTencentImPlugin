import 'package:flutter/material.dart';
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

  FriendInfoEntity({
    @required this.userID,
    this.friendRemark,
    this.friendCustomInfo,
  });

  FriendInfoEntity.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    friendRemark = json['friendRemark'];
    friendGroups = json['friendGroups'];
    friendCustomInfo = json['friendCustomInfo'];
    userProfile = UserEntity.fromJson(json['userProfile']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userID != null) data['userID'] = this.userID;
    if (this.friendRemark != null) data['friendRemark'] = this.friendRemark;
    if (this.friendCustomInfo != null)
      data['friendCustomInfo'] = this.friendCustomInfo;
    return data;
  }
}
