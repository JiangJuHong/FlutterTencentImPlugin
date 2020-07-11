import 'package:tencent_im_plugin/message_node/custom_message_node.dart';
import 'package:tencent_im_plugin/message_node/group_system_message_node.dart';
import 'package:tencent_im_plugin/message_node/group_tips_message_node.dart';
import 'package:tencent_im_plugin/message_node/image_message_node.dart';
import 'package:tencent_im_plugin/message_node/location_message_node.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';
import 'package:tencent_im_plugin/message_node/other_message_node.dart';
import 'package:tencent_im_plugin/message_node/profile_system_message_node.dart';
import 'package:tencent_im_plugin/message_node/sound_message_node.dart';
import 'package:tencent_im_plugin/message_node/text_message_node.dart';
import 'package:tencent_im_plugin/message_node/video_message_node.dart';
import 'package:tencent_im_plugin/message_node/sns_tips_message_node.dart';

/// 消息节点类型
enum MessageNodeType {
  // 文本
  Text,

  // 图片
  Image,

  // 语音
  Sound,

  // 自定义
  Custom,

  // 视频
  Video,

  // 位置
  Location,

  // 群提示
  GroupTips,

  // 关系链操作
  SnsTips,

  // 群系统消息
  GroupSystem,

  // 用户资料变更系统通知
  ProfileSystem,

  // 其它
  Other,
}

/// 消息节点类型工具类
class MessageNodeTypeUtil {
  /// 根据枚举获得消息节点
  static MessageNode getMessageNodeByMessageNodeType(MessageNodeType nodeType, Map<String, dynamic> json) {
    switch (nodeType) {
      case MessageNodeType.Text:
        return TextMessageNode.fromJson(json);
      case MessageNodeType.Image:
        return ImageMessageNode.fromJson(json);
        break;
      case MessageNodeType.Sound:
        return SoundMessageNode.fromJson(json);
        break;
      case MessageNodeType.Custom:
        return CustomMessageNode.fromJson(json);
        break;
      case MessageNodeType.Video:
        return VideoMessageNode.fromJson(json);
        break;
      case MessageNodeType.Location:
        return LocationMessageNode.fromJson(json);
        break;
      case MessageNodeType.GroupTips:
        return GroupTipsMessageNode.fromJson(json);
        break;
      case MessageNodeType.SnsTips:
        return SnsTipsMessageNode.fromJson(json);
        break;
      case MessageNodeType.GroupSystem:
        return GroupSystemMessageNode.fromJson(json);
      case MessageNodeType.Other:
        return OtherMessageNode.fromJson(json);
        break;
      case MessageNodeType.ProfileSystem:
        return ProfileSystemMessageNode.fromJson(json);
        break;
    }
    return null;
  }
}
