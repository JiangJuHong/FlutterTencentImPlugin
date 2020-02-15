/// 检测好友关系枚举
enum FriendCheckTypeEnum {
  // 单项好友
  unidirection,
  // 互为好友
  bidirection
}

/// 枚举工具
class FriendCheckTypeTool {
  /// 根据数标获得枚举
  static FriendCheckTypeEnum getEnumByIndex(index) {
    switch (index) {
      case 1:
        return FriendCheckTypeEnum.unidirection;
      case 2:
        return FriendCheckTypeEnum.bidirection;
      default:
        return null;
    }
  }

  /// 根据枚举获得数标
  static int getIndexByEnum(e) {
    switch (e) {
      case FriendCheckTypeEnum.unidirection:
        return 1;
      case FriendCheckTypeEnum.bidirection:
        return 2;
      default:
        return null;
    }
  }
}
