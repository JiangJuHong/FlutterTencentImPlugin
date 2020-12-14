import 'dart:convert';

import 'package:tencent_im_plugin/entity/friend_application_entity.dart';
import 'package:tencent_im_plugin/entity/friend_application_result_entity.dart';
import 'package:tencent_im_plugin/entity/friend_group_entity.dart';
import 'package:tencent_im_plugin/entity/friend_info_entity.dart';
import 'package:tencent_im_plugin/entity/friend_info_result_entity.dart';
import 'package:tencent_im_plugin/entity/friend_operation_result_entity.dart';
import 'package:tencent_im_plugin/entity/group_application_entity.dart';
import 'package:tencent_im_plugin/entity/group_at_info_entity.dart';
import 'package:tencent_im_plugin/entity/group_changed_entity.dart';
import 'package:tencent_im_plugin/entity/group_info_result_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_changed_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_operation_result_entity.dart';
import 'package:tencent_im_plugin/entity/group_info_entity.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/entity/message_receipt_entity.dart';
import 'package:tencent_im_plugin/entity/user_entity.dart';
import 'entity/conversation_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (json is String) {
      json = jsonDecode(json);
    }

    if (1 == 0) {
      return null;
    } else if (T.toString() == "GroupInfoEntity") {
      return GroupInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "MessageEntity") {
      return MessageEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupMemberEntity") {
      return GroupMemberEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupInfoResultEntity") {
      return GroupInfoResultEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupMemberOperationResultEntity") {
      return GroupMemberOperationResultEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupApplicationEntity") {
      return GroupApplicationEntity.fromJson(json) as T;
    } else if (T.toString() == "ConversationEntity") {
      return ConversationEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupAtInfoEntity") {
      return GroupAtInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "UserEntity") {
      return UserEntity.fromJson(json) as T;
    } else if (T.toString() == "FriendOperationResultEntity") {
      return FriendOperationResultEntity.fromJson(json) as T;
    } else if (T.toString() == "FriendInfoEntity") {
      return FriendInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "FriendInfoResultEntity") {
      return FriendInfoResultEntity.fromJson(json) as T;
    } else if (T.toString() == "FriendApplicationResultEntity") {
      return FriendApplicationResultEntity.fromJson(json) as T;
    } else if (T.toString() == "FriendApplicationEntity") {
      return FriendApplicationEntity.fromJson(json) as T;
    } else if (T.toString() == "FriendGroupEntity") {
      return FriendGroupEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupChangedInfoEntity") {
      return GroupChangedInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupMemberChangedInfoEntity") {
      return GroupMemberChangedInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "MessageReceiptEntity") {
      return MessageReceiptEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
