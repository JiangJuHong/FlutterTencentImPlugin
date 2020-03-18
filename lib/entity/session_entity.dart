import 'package:tencent_im_plugin/entity/group_info_entity.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/entity/user_info_entity.dart';
import 'package:tencent_im_plugin/utils/enum_util.dart';

/// 会话实体
class SessionEntity {
  // 封面(头像)
  String faceUrl;

  // 未读消息数量
  int unreadMessageNum;

  // 昵称(用户:用户昵称，群:群昵称，系统:空)
  String nickname;

  // 会话ID(C2C：对方账号；Group：群组Id)
  String id;

  // 会话类型
  SessionType type;

  // 最近一条消息
  MessageEntity message;

  // 群
  GroupInfoEntity group;

  // 用户
  UserInfoEntity userProfile;

  SessionEntity({
    this.faceUrl,
    this.unreadMessageNum,
    this.nickname,
    this.id,
    this.type,
    this.message,
    this.group,
    this.userProfile,
  });

  SessionEntity.fromJson(Map<String, dynamic> json) {
    faceUrl = json['faceUrl'];
    unreadMessageNum = json['unreadMessageNum'];
    nickname = json['nickname'];
    id = json['id'];
    for (var item in SessionType.values) {
      if (EnumUtil.getEnumName(item) == json['type']) {
        type = item;
      }
    }
    message = json["message"] != null
        ? MessageEntity.fromJson(json["message"])
        : null;

    group =
        json["group"] != null ? GroupInfoEntity.fromJson(json["group"]) : null;
    userProfile = json["userProfile"] != null
        ? UserInfoEntity.fromJson(json["userProfile"])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['faceUrl'] = this.faceUrl;
    data['unreadMessageNum'] = this.unreadMessageNum;
    data['nickname'] = this.nickname;
    data['id'] = this.id;
    data['type'] = this.type.toString();
    data['message'] = this.message.toJson();
    data['group'] = this.group.toJson();
    data['userProfile'] = this.userProfile.toJson();
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type;

  @override
  int get hashCode => id.hashCode ^ type.hashCode;
}

/// 会话类型
enum SessionType {
  // 用户对话
  C2C,
  // 系统对话
  System,
  // 群对话
  Group,
}
