import 'node_entity.dart';

/// 位置节点
class NodeLocationEntity extends NodeEntity {
  /// 位置描述
  String desc;

  /// 经度
  double longitude;

  /// 纬度
  double latitude;

  NodeLocationEntity.fromJson(Map<String, dynamic> json) {
    type = NodeEntity.fromJson(json).type;
    desc = json['desc'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['desc'] = this.desc;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}
