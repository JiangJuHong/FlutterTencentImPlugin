import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/enums/friend_application_type_enum.dart';

/// 查找好友申请实体
class FindFriendApplicationEntity {
  /// 用户ID
  String userID;

  /// 类型
  FriendApplicationTypeEnum type;

  FindFriendApplicationEntity({
    @required this.userID,
    @required this.type,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["userID"] = userID;
    data["type"] = FriendApplicationTypeTool.toInt(type);
    return data;
  }
}
