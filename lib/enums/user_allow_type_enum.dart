/// 用户验证方式枚举
enum UserAllowTypeEnum {
  // 允许任何人
  AllowAny,
  // 需要确认
  NeedConfirm,
  // 拒绝任何人
  DenyAny,
}

class UserAllowTypeTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static UserAllowTypeEnum getByInt(int index) =>
      UserAllowTypeEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(UserAllowTypeEnum level) => level.index;
}
