import 'node_entity.dart';

/// 其它节点
class NodeOtherEntity extends NodeEntity {
  // 内容
  Map<String, dynamic> content;

  NodeOtherEntity();

  NodeOtherEntity.fromJson(Map<String, dynamic> json) {
    this.content = json;
  }

  Map<String, dynamic> toJson() {
    return content;
  }
}
