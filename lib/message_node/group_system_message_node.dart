import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/entity/user_info_entity.dart';
import 'package:tencent_im_plugin/enums/group_system_type.dart';
import 'package:tencent_im_plugin/enums/message_node_type.dart';

import 'message_node.dart';

/// 群系统消息节点
class GroupSystemMessageNode extends MessageNode {
  /// 操作方平台信息
  /// 取值： iOS Android Windows Mac Web RESTAPI Unknown
  String platform;

  /// 消息子类型
  GroupSystemType subtype;

  /// 群ID
  String groupId;

  /// 自定义通知
  String userData;

  /// 操作者个人资料
  UserInfoEntity opUserInfo;

  /// 操作者群内资料
  GroupMemberEntity opGroupMemberInfo;

  GroupSystemMessageNode() : super(MessageNodeType.GroupSystem);

  GroupSystemMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageNodeType.GroupSystem) {
    this.platform = json["platform"];
    this.groupId = json["groupId"];
    this.subtype = GroupSystemTypeTool.intToGroupSystemType(json["subtype"]);
    if (json["opUserInfo"] != null) {
      opUserInfo = UserInfoEntity.fromJson(json["opUserInfo"]);
    }
    if (json["opGroupMemberInfo"] != null) {
      this.opGroupMemberInfo =
          GroupMemberEntity.fromJson(json["opGroupMemberInfo"]);
    }
  }
}
