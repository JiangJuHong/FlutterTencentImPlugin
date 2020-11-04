import 'package:tencent_im_plugin/entity/group_application_entity.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群申请列表结果实体
class GroupApplicationResultEntity {
  /// 未读申请数量
  int unreadCount;

  /// 加群的申请列表
  List<GroupApplicationEntity> groupApplicationList;

  GroupApplicationResultEntity.fromJson(Map<String, dynamic> json) {
    unreadCount = json['unreadCount'];
    groupApplicationList = ListUtil.generateOBJList<GroupApplicationEntity>(
        json['groupApplicationList']);
  }
}
