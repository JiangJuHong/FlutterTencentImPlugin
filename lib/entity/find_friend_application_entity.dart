import 'package:tencent_im_plugin/entity/friend_application_entity.dart';
import 'package:tencent_im_plugin/enums/friend_application_type_enum.dart';

/// 查找好友申请实体
class FindFriendApplicationEntity {
  /// 用户ID
  String userID;

  /// 类型
  FriendApplicationTypeEnum type;

  FindFriendApplicationEntity({
    required this.userID,
    required this.type,
  });

  /// 根据[data]对象快速转换为查找好友申请实体
  factory FindFriendApplicationEntity.fromFriendApplicationEntity(FriendApplicationEntity data) {
    return FindFriendApplicationEntity(userID: data.userID, type: data.type);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["userID"] = userID;
    data["type"] = FriendApplicationTypeTool.toInt(type);
    return data;
  }
}
