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
  static MessageElemTypeEnum getByInt(int index) => MessageElemTypeEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(MessageElemTypeEnum level) => level.index;
}
