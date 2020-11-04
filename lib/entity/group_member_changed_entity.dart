import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群成员改变通知实体
class GroupMemberChangedEntity {
  /// 群ID
  String groupID;

  /// 群成员列表
  List<GroupMemberEntity> changInfo;

  GroupMemberChangedEntity.fromJson(Map<String, dynamic> json) {
    groupID = json['groupID'];
    if (json["changInfo"] != null) changInfo = ListUtil.generateOBJList<GroupMemberEntity>(json['changInfo']);
  }
}
