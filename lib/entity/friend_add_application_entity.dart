import 'package:tencent_im_plugin/enums/friend_type_enum.dart';

/// 好友添加申请实体
class FriendAddApplicationEntity {
  /// 用户ID
  String userID;

  /// 好友备注
  String friendRemark;

  /// 申请描述
  String addWording;

  /// 添加来源
  String addSource;

  /// 添加类型
  FriendTypeEnum addType;

  FriendAddApplicationEntity({
    this.userID,
    this.friendRemark,
    this.addWording,
    this.addSource,
    this.addType,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userID != null) data['userID'] = this.userID;
    if (this.friendRemark != null) data['friendRemark'] = this.friendRemark;
    if (this.addWording != null) data['addWording'] = this.addWording;
    if (this.addSource != null) data['addSource'] = this.addSource;
    if (this.addType != null)
      data['addType'] = FriendTypeTool.toInt(this.addType);
    return data;
  }
}
