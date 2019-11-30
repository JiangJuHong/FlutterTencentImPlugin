import 'node_entity.dart';

/// 文本节点
class NodeTextEntity extends NodeEntity {
  // 文本内容
  String text;

  NodeTextEntity({
    this.text,
  });

  NodeTextEntity.fromJson(Map<String, dynamic> json) {
    type = NodeEntity.fromJson(json).type;
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['text'] = this.text;
    return data;
  }
}
