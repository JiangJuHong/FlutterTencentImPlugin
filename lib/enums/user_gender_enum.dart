/// 用户性别枚举
enum UserGenderEnum {
  // 未知
  Unknown,
  // 男
  Male,
  // 女
  Female,
}

class UserGenderTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static UserGenderEnum getByInt(int index) => UserGenderEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(UserGenderEnum level) => level.index;
}
