import 'package:tencent_im_plugin/enums/friend_status_enum.dart';

/// 添加好友结果
class AddFriendResultEntity {
  String identifier;
  FriendStatusEnum resultCode;
  String resultInfo;

  AddFriendResultEntity({this.identifier, this.resultCode, this.resultInfo});

  AddFriendResultEntity.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    resultCode = FriendStatusEnumTool.getEnumByIndex(json['resultCode']);
    resultInfo = json['resultInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['resultCode'] = FriendStatusEnumTool.getIndexByEnum(this.resultCode);
    data['resultInfo'] = this.resultInfo;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddFriendResultEntity &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;
}
