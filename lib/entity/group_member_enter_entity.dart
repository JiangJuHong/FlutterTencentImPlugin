import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群成员加入通知实体
class GroupMemberEnterEntity {
  /// 群ID
  String groupID;

  /// 群成员列表
  List<GroupMemberEntity> memberList;

  GroupMemberEnterEntity.fromJson(Map<String, dynamic> json) {
    groupID = json['groupID'];
    if (json["memberList"] != null)
      memberList =
          ListUtil.generateOBJList<GroupMemberEntity>(json['memberList']);
  }
}
