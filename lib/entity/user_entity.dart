import 'dart:convert';

import 'package:tencent_im_plugin/enums/user_allow_type_enum.dart';
import 'package:tencent_im_plugin/enums/user_gender_enum.dart';

/// 用户实体
class UserEntity {
  /// ID
  String userID;

  /// 昵称
  String nickName;

  /// 头像
  String faceUrl;

  /// 签名
  String selfSignature;

  /// 性别
  UserGenderEnum gender;

  /// 角色
  int role;

  /// 等级
  int level;

  /// 好友验证方式
  UserAllowTypeEnum allowType;

  /// 自定义字段
  Map<String, String> customInfo;

  UserEntity({
    this.nickName,
    this.faceUrl,
    this.selfSignature,
    this.gender,
    this.role,
    this.level,
    this.allowType,
    this.customInfo,
  });

  UserEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    userID = json['userID'];
    nickName = json['nickName'];
    faceUrl = json['faceUrl'];
    selfSignature = json['selfSignature'];
    gender = UserGenderTool.getByInt(json['gender']);
    role = json['role'];
    level = json['level'];
    allowType = UserAllowTypeTool.getByInt(json['allowType']);
    customInfo = json['customInfo']?.cast<String, String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nickName != null) data['nickName'] = this.nickName;
    if (this.faceUrl != null) data['faceUrl'] = this.faceUrl;
    if (this.selfSignature != null) data['selfSignature'] = this.selfSignature;
    if (this.gender != null) data['gender'] = UserGenderTool.toInt(this.gender);
    if (this.role != null) data['role'] = this.role;
    if (this.level != null) data['level'] = this.level;
    if (this.allowType != null)
      data['allowType'] = UserAllowTypeTool.toInt(this.allowType);
    if (this.customInfo != null) data['customInfo'] = this.customInfo;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          userID == other.userID;

  @override
  int get hashCode => userID.hashCode;
}
