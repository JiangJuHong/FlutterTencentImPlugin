import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 语音消息节点
class SoundMessageNode extends MessageNode {
  /// 语音ID
  String? _uuid;

  /// 路径
  String? path;

  /// 时长
  late int duration;

  /// 数据大小
  int? _dataSize;

  SoundMessageNode({
    required this.path,
    required this.duration,
  }) : super(MessageElemTypeEnum.Sound);

  SoundMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageElemTypeEnum.Sound) {
    if (json['uuid'] != null) _uuid = json['uuid'];
    if (json['path'] != null) path = json['path'];
    if (json['duration'] != null) duration = json['duration'];
    if (json['dataSize'] != null) _dataSize = json['dataSize'];
  }

  /// 获得语音ID
  String? get uuid => _uuid;

  /// 获得数据大小
  int? get dataSize => _dataSize;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["path"] = this.path;
    data["duration"] = this.duration;
    return data;
  }
}
