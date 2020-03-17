import 'package:tencent_im_plugin/entity/user_info_entity.dart';
import 'package:tencent_im_plugin/enums/pendency_type_enum.dart';

/// 未决对象(申请)
class PendencyEntity {
  String identifier;
  String addSource;
  int addTime;
  String addWording;
  String nickname;
  PendencyTypeEnum type;
  UserInfoEntity userProfile;

  PendencyEntity({
    this.identifier,
    this.addSource,
    this.addTime,
    this.addWording,
    this.nickname,
    this.type,
    this.userProfile,
  });

  PendencyEntity.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    addSource = json['addSource'];
    addTime = json['addTime'];
    addWording = json['addWording'];
    nickname = json['nickname'];
    type = PendencyTypeTool.getEnumByIndex(json['type']);
    userProfile = json['userProfile'] != null
        ? new UserInfoEntity.fromJson(json['userProfile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['addSource'] = this.addSource;
    data['addTime'] = this.addTime;
    data['addWording'] = this.addWording;
    data['nickname'] = this.nickname;
    data['type'] = PendencyTypeTool.getIndexByEnum(this.type);
    if (this.userProfile != null) {
      data['userProfile'] = this.userProfile.toJson();
    }
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendencyEntity &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;
}
