import 'package:tencent_im_plugin/enums/friend_relation_type_enum.dart';

/// 检测好友关系结果
class CheckFriendResultEntity {
  String identifier;
  int resultCode;
  FriendRelationTypeEnum resultType;
  String resultInfo;

  CheckFriendResultEntity(
      {this.identifier, this.resultCode, this.resultType, this.resultInfo});

  CheckFriendResultEntity.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    resultCode = json['resultCode'];
    resultType = FriendRelationTypeEnum.values[json['resultType']];
    resultInfo = json['resultInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['resultCode'] = this.resultCode;
    data['resultType'] = this.resultType.index;
    data['resultInfo'] = this.resultInfo;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckFriendResultEntity &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;
}
