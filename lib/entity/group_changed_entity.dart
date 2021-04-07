import 'dart:convert';
import 'package:tencent_im_plugin/enums/group_info_changed_type_enum.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群改变通知实体
class GroupChangedEntity {
  /// 群ID
  late String groupID;

  /// 群改变信息实体
  late List<GroupChangedInfoEntity> changInfo;

  GroupChangedEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['groupID'] != null) groupID = json['groupID'];
    if (json["changInfo"] != null)
      changInfo =
          ListUtil.generateOBJList<GroupChangedInfoEntity>(json['changInfo']);
  }
}

/// 群改变实体
class GroupChangedInfoEntity {
  /// 类型
  late GroupInfoChangedTypeEnum type;

  /// Key
  String? key;

  /// Value
  String? value;

  GroupChangedInfoEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['type'] != null)
      type = GroupInfoChangedTypeTool.getByInt(json['type']);
    if (json['key'] != null) key = json['key'];
    if (json['value'] != null) value = json['value'];
  }
}
