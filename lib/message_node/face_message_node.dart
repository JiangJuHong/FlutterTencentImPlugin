import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 表情消息节点
class FaceMessageNode extends MessageNode {
  /// 索引
  late int index;

  /// 数据
  late String data;

  FaceMessageNode({
    required this.index,
    required this.data,
  }) : super(MessageElemTypeEnum.Face);

  FaceMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageElemTypeEnum.Face) {
    if (json['index'] != null) this.index = json["index"];
    if (json['data'] != null) this.data = json["data"];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["index"] = this.index;
    data["data"] = this.data;
    return data;
  }
}
