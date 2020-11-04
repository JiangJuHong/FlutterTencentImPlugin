/// 登录状态枚举
enum LoginStatusEnum {
  // 已登录
  Logined,
  // 登录中
  Logining,
  // 未登录
  Logout,
}

class LoginStatusTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static LoginStatusEnum getByInt(int index) =>
      LoginStatusEnum.values[index - 1];
}
