import 'package:tencent_im_plugin/entity/group_info_entity.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';
import 'package:tencent_im_plugin/entity/node_entity.dart';
import 'package:tencent_im_plugin/entity/node_text_entity.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/entity/user_info_entity.dart';
import 'package:tencent_im_plugin/entity/node_image_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "GroupInfoEntity") {
      return GroupInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "SessionEntity") {
      return SessionEntity.fromJson(json) as T;
    } else if (T.toString() == "NodeEntity") {
      return NodeEntity.fromJson(json) as T;
    } else if (T.toString() == "NodeTextEntity") {
      return NodeTextEntity.fromJson(json) as T;
    } else if (T.toString() == "MessageEntity") {
      return MessageEntity.fromJson(json) as T;
    } else if (T.toString() == "UserInfoEntity") {
      return UserInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "NodeImageEntity") {
      return NodeImageEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}