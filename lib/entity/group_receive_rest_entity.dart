import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/list_util.dart';

/// 群接收到REST自定义信息通知实体
class GroupReceiveRESTEntity {
  /// 群ID
  String groupID;

  /// 自定义数据
  String customData;

  GroupReceiveRESTEntity.fromJson(Map<String, dynamic> json) {
    groupID = json['groupID'];
    customData = json['customData'];
  }
}
