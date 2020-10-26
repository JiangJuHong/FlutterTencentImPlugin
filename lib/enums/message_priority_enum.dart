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

/// 消息优先级枚举
enum MessagePriorityEnum {
  // 默认为普通优先级
  Default,
  // 高优先级，一般用于礼物等重要消息
  Hign,
  // 普通优先级，一般用于普通消息
  Normal,
  // 低优先级，一般用于点赞消息
  Low,
}

class MessagePriorityTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static MessagePriorityEnum getByInt(int index) => MessagePriorityEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(MessagePriorityEnum level) => level.index;
}
