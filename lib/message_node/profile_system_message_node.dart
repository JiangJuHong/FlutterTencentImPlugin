import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/entity/user_info_entity.dart';
import 'package:tencent_im_plugin/enums/group_system_type.dart';
import 'package:tencent_im_plugin/enums/message_node_type.dart';

import 'message_node.dart';

/// 用户资料变更系统通知节点
class ProfileSystemMessageNode extends MessageNode {
  /// 资料变更类型
  int subType;

  /// 资料变更的用户名
  String fromUser;

  /// 资料变更的昵称
  String nickName;

  ProfileSystemMessageNode.fromJson(Map<String, dynamic> json) : super(MessageNodeType.GroupSystem) {
    this.subType = json["subType"];
    this.fromUser = json["fromUser"];
    this.nickName = json["nickName"];
  }
}
