/// 好友申请接收时类型枚举
enum FriendApplicationAgreeTypeEnum {
  // 同意加好友（建立单向好友）
  Agree,
  // 同意加好友并加对方为好友（建立双向好友）
  AgreeAndAdd,
}

/// 枚举工具
class FriendApplicationAgreeTypeTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static FriendApplicationAgreeTypeEnum getByInt(int index) =>
      FriendApplicationAgreeTypeEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(FriendApplicationAgreeTypeEnum level) => level.index;
}
