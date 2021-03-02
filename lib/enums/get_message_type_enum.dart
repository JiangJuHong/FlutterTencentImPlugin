/// 获得消息类型枚举
enum GetMessageTypeEnum {
  // 云端更老的消息
  GetCloudOlderMsg,
  // 云端更新的消息
  GetCloudNewerMsg,
  // 本地更老的消息
  GetLocalOlderMsg,
  // 本地更新的消息
  GetLocalNewerMsg,
}

/// 枚举工具
class GetMessageTypeTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static GetMessageTypeEnum getByInt(int index) =>
      GetMessageTypeEnum.values[index - 1];

  /// 将枚举转换为整型
  static int toInt(GetMessageTypeEnum level) => level.index + 1;
}
