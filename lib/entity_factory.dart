import 'package:tencent_im_plugin/entity/add_friend_result_entity.dart';
import 'package:tencent_im_plugin/entity/group_tips_elem_member_info_entity.dart';
import 'package:tencent_im_plugin/entity/pendency_entity.dart';
import 'package:tencent_im_plugin/entity/group_pendency_entity.dart';
import 'package:tencent_im_plugin/entity/group_info_entity.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';
import 'package:tencent_im_plugin/entity/check_friend_result_entity.dart';
import 'package:tencent_im_plugin/entity/pendency_page_entity.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/entity/user_info_entity.dart';
import 'package:tencent_im_plugin/entity/friend_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/entity/group_pendency_page_entity.dart';

import 'entity/group_tips_elem_group_info_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "AddFriendResultEntity") {
      return AddFriendResultEntity.fromJson(json) as T;
    } else if (T.toString() == "PendencyEntity") {
      return PendencyEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupPendencyEntity") {
      return GroupPendencyEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupInfoEntity") {
      return GroupInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "SessionEntity") {
      return SessionEntity.fromJson(json) as T;
    } else if (T.toString() == "CheckFriendResultEntity") {
      return CheckFriendResultEntity.fromJson(json) as T;
    } else if (T.toString() == "PendencyPageEntity") {
      return PendencyPageEntity.fromJson(json) as T;
    } else if (T.toString() == "MessageEntity") {
      return MessageEntity.fromJson(json) as T;
    } else if (T.toString() == "UserInfoEntity") {
      return UserInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "FriendEntity") {
      return FriendEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupMemberEntity") {
      return GroupMemberEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupPendencyPageEntity") {
      return GroupPendencyPageEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupTipsElemMemberInfoEntity") {
      return GroupTipsElemMemberInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "GroupTipsElemGroupInfoEntity") {
      return GroupTipsElemGroupInfoEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
