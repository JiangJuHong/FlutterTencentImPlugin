import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/enums/group_info_changed_type_enum.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群改变通知实体
class GroupChangedEntity {
  /// 群ID
  String groupID;

  /// 群成员列表
  List<GroupChangedInfoEntity> changInfo;

  GroupChangedEntity.fromJson(Map<String, dynamic> json) {
    groupID = json['groupID'];
    if (json["changInfo"] != null) changInfo = ListUtil.generateOBJList<GroupChangedInfoEntity>(json['changInfo']);
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

  GroupChangedInfoEntity.fromJson(Map<String, dynamic> json) {
    type = GroupInfoChangedTypeTool.getByInt(json['type']);
    key = json['key'];
    value = json['value'];
  }
}
