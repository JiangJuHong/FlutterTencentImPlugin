/// 好友类型枚举
enum FriendTypeEnum {
  // 单项加好友
  Single,
  // 双向加好友
  Both,
}

/// 枚举工具
class FriendTypeTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static FriendTypeEnum getByInt(int index) => FriendTypeEnum.values[index - 1];

  /// 将枚举转换为整型
  static int toInt(FriendTypeEnum level) => level.index + 1;
}
