import 'dart:convert';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/enums/group_info_changed_type_enum.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群改变通知实体
class GroupChangedEntity {
  /// 群ID
  String groupID;

  /// 群改变信息实体
  List<GroupChangedInfoEntity> changInfo;

  GroupChangedEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    groupID = json['groupID'];
    if (json["changInfo"] != null)
      changInfo =
          ListUtil.generateOBJList<GroupChangedInfoEntity>(json['changInfo']);
  }
}

/// 群改变实体
class GroupChangedInfoEntity {
  /// 类型
  GroupInfoChangedTypeEnum type;

  /// Key
  String key;

  /// Value
  String value;

  GroupChangedInfoEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    type = GroupInfoChangedTypeTool.getByInt(json['type']);
    key = json['key'];
    value = json['value'];
  }
}
