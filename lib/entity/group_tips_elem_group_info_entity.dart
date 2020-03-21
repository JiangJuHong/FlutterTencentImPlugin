import 'package:tencent_im_plugin/enums/group_tips_group_info_type.dart';
import 'package:tencent_im_plugin/utils/enum_util.dart';

/// 群tips，群资料变更消息
class GroupTipsElemGroupInfoEntity {
  /// 消息内容
  String content;

  /// 如果变更类型是群自定义字段，key 对应的是具体变更的字段，群自定义字段的变更只会通过 TIMUserConfig -> TIMGroupEventListener 回调给客户
  String key;

  /// 群资料变更消息类型
  GroupTipsGroupInfoType type;

  GroupTipsElemGroupInfoEntity.fromJson(Map<String, dynamic> json) {
    content = json["content"];
    key = json["key"];
    type = EnumUtil.nameOf(GroupTipsGroupInfoType.values, json["key"]);
  }
}
