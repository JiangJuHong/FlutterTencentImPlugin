import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';

/// 适配消息节点
class VideoMessageNode extends MessageNode {
  /// 视频路径
  String? videoPath;

  /// 视频UUID
  String? _videoUuid;

  /// 视频大小
  int? _videoSize;

  /// 时长
  late int duration;

  /// 缩略图路径
  String? snapshotPath;

  /// 缩略图UUID
  String? _snapshotUuid;

  /// 缩略图大小
  int? _snapshotSize;

  /// 缩略图宽度
  int? _snapshotWidth;

  /// 缩略图高度
  int? _snapshotHeight;

  VideoMessageNode({
    required this.videoPath,
    required this.duration,
    required this.snapshotPath,
  }) : super(MessageElemTypeEnum.Video);

  VideoMessageNode.fromJson(Map<String, dynamic> json)
      : super(MessageElemTypeEnum.Video) {
    if (json['videoPath'] != null) videoPath = json["videoPath"];
    if (json['videoUuid'] != null) _videoUuid = json["videoUuid"];
    if (json['videoSize'] != null) _videoSize = json["videoSize"];
    if (json['duration'] != null) duration = json["duration"];
    if (json['snapshotPath'] != null) snapshotPath = json["snapshotPath"];
    if (json['snapshotUuid'] != null) _snapshotUuid = json["snapshotUuid"];
    if (json['snapshotSize'] != null) _snapshotSize = json["snapshotSize"];
    if (json['snapshotWidth'] != null) _snapshotWidth = json["snapshotWidth"];
    if (json['snapshotHeight'] != null)
      _snapshotHeight = json["snapshotHeight"];
  }

  /// 获得视频UUID
  String? get videoUuid => _videoUuid;

  /// 获得视频大小
  int? get videoSize => _videoSize;

  /// 获得缩略图UUID
  String? get snapshotUuid => _snapshotUuid;

  /// 获得缩略图大小
  int? get snapshotSize => _snapshotSize;

  /// 获得缩略图宽度
  int? get snapshotWidth => _snapshotWidth;

  /// 获得缩略图高度
  int? get snapshotHeight => _snapshotHeight;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data["videoPath"] = this.videoPath;
    data["duration"] = this.duration;
    data["snapshotPath"] = this.snapshotPath;
    return data;
  }
}
