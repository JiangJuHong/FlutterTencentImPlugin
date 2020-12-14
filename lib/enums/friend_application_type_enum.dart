/// 好友申请类型枚举
enum FriendApplicationTypeEnum {
  // 别人发给我的加好友请求
  ComeIn,
  // 我发给别人的加好友请求
  SendOut,
  // 别人发给我的和我发给别人的加好友请求。仅在拉取时有效。
  Both,
}

/// 枚举工具
class FriendApplicationTypeTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static FriendApplicationTypeEnum getByInt(int index) =>
      FriendApplicationTypeEnum.values[index - 1];

  /// 将枚举转换为整型
  static int toInt(FriendApplicationTypeEnum level) => level.index + 1;
}
