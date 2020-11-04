/// 好友关系枚举
enum FriendRelationTypeEnum {
  // 不是好友
  None,
  // 在我的好友列表
  MyFriendList,
  // 我在对方好友列表
  OtherFriendList,
  // 互为好友
  BothWay,
}

/// 枚举工具
class FriendRelationTypeTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static FriendRelationTypeEnum getByInt(int index) =>
      FriendRelationTypeEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(FriendRelationTypeEnum level) => level.index;
}
