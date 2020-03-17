/// 添加好友关系枚举
enum FriendAddTypeEnum {
  // 单项加好友
  single,
  // 双向加好友
  both,
}

/// 枚举工具
class FriendAddTypeTool {
  /// 根据数标获得枚举
  static FriendAddTypeEnum getEnumByIndex(index) {
    switch (index) {
      case 1:
        return FriendAddTypeEnum.single;
      case 2:
        return FriendAddTypeEnum.both;
      default:
        return null;
    }
  }

  /// 根据枚举获得数标
  static int getIndexByEnum(e) {
    switch (e) {
      case FriendAddTypeEnum.single:
        return 1;
      case FriendAddTypeEnum.both:
        return 2;
      default:
        return null;
    }
  }
}
