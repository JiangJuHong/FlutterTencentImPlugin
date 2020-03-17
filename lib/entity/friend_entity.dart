import 'package:tencent_im_plugin/entity/user_info_entity.dart';

/// 好友实体
class FriendEntity {
  /// ID
  String identifier;

  /// 添加来源
  String addSource;

  /// 添加时间
  int addTime;

  /// 申请描述
  String addWording;

  /// 备注
  String remark;

  /// 用户信息
  UserInfoEntity userInfoEntity;

  FriendEntity({
    this.identifier,
    this.addSource,
    this.addTime,
    this.addWording,
    this.remark,
    this.userInfoEntity,
  });

  FriendEntity.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    addSource = json['addSource'];
    addTime = json['addTime'];
    addWording = json['addWording'];
    remark = json['remark'];
    userInfoEntity = json['timUserProfile'] == null
        ? null
        : UserInfoEntity.fromJson(json['timUserProfile']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['addSource'] = this.addSource;
    data['addTime'] = this.addTime;
    data['addWording'] = this.addWording;
    data['remark'] = this.remark;
    if (this.userInfoEntity != null) {
      data['timUserProfile'] = this.userInfoEntity.toJson();
    }
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FriendEntity &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;
}
