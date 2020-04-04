import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/enums/sns_tips_type.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';
import 'package:tencent_im_plugin/utils/enum_util.dart';

/// 关系链操作节点
class SnsTipsMessageNode extends MessageNode {
  /// 未决已读上报时间戳 type == TIMSNSSystemType.TIM_SNS_SYSTEM_PENDENCY_REPORT 时有效
  int pendencyReportTimestamp;

  /// 子类型
  SnsTipsType subType;

  SnsTipsMessageNode() : super(MessageNodeType.SnsTips);

  SnsTipsMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageNodeType.SnsTips) {
    pendencyReportTimestamp = json["pendencyReportTimestamp"];
    subType = EnumUtil.nameOf(SnsTipsType.values, json["subType"]);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}
