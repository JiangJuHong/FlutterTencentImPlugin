import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 位置节点
class LocationMessageNode extends MessageNode {
  /// 位置描述
  late String desc;

  /// 经度
  late double longitude;

  /// 纬度
  late double latitude;

  LocationMessageNode({
    required this.desc,
    required this.longitude,
    required this.latitude,
  }) : super(MessageElemTypeEnum.Location);

  LocationMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageElemTypeEnum.Location) {
    if (json['desc'] != null) desc = json['desc'];
    if (json['longitude'] != null) longitude = json['longitude'];
    if (json['latitude'] != null) latitude = json['latitude'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["desc"] = this.desc;
    data["longitude"] = this.longitude;
    data["latitude"] = this.latitude;
    return data;
  }
}
