import 'package:tencent_im_plugin/message_node/custom_message_node.dart';
import 'package:tencent_im_plugin/message_node/face_message_node.dart';
import 'package:tencent_im_plugin/message_node/file_message_node.dart';
import 'package:tencent_im_plugin/message_node/group_tips_message_node.dart';
import 'package:tencent_im_plugin/message_node/image_message_node.dart';
import 'package:tencent_im_plugin/message_node/location_message_node.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';
import 'package:tencent_im_plugin/message_node/sound_message_node.dart';
import 'package:tencent_im_plugin/message_node/text_message_node.dart';
import 'package:tencent_im_plugin/message_node/video_message_node.dart';

/// 消息节点类型
enum MessageElemTypeEnum {
  // 没有元素
  None,

  // 文本
  Text,

  // 自定义
  Custom,

  // 图片
  Image,

  // 语音
  Sound,

  // 视频
  Video,

  // 文件
  File,

  // 位置
  Location,

  // 表情
  Face,

  // 群提示
  GroupTips,
}

class MessageElemTypeTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static MessageElemTypeEnum getByInt(int index) =>
      MessageElemTypeEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(MessageElemTypeEnum level) => level.index;

  /// 根据消息节点类型获得消息节点
  /// [nodeType] 节点类型
  /// [json] json值
  static MessageNode getMessageNodeByMessageNodeType(
      MessageElemTypeEnum nodeType, Map<String, dynamic> json) {
    switch (nodeType) {
      case MessageElemTypeEnum.None:
        break;
      case MessageElemTypeEnum.Text:
        return TextMessageNode.fromJson(json);
      case MessageElemTypeEnum.Custom:
        return CustomMessageNode.fromJson(json);
      case MessageElemTypeEnum.Image:
        return ImageMessageNode.fromJson(json);
        break;
      case MessageElemTypeEnum.Sound:
        return SoundMessageNode.fromJson(json);
        break;
      case MessageElemTypeEnum.Video:
        return VideoMessageNode.fromJson(json);
        break;
      case MessageElemTypeEnum.File:
        return FileMessageNode.fromJson(json);
        break;
      case MessageElemTypeEnum.Location:
        return LocationMessageNode.fromJson(json);
        break;
      case MessageElemTypeEnum.Face:
        return FaceMessageNode.fromJson(json);
        break;
      case MessageElemTypeEnum.GroupTips:
        return GroupTipsMessageNode.fromJson(json);
        break;
    }
    return null;
  }
}
