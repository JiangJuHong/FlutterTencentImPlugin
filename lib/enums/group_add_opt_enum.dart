/// 加群选项
enum GroupAddOptEnum {
  /// 禁止加群
  Forbid,

  /// 需要管理员审批
  Auth,

  /// 自由加入
  Any,
}

class GroupAddOptTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static GroupAddOptEnum getByInt(int index) => GroupAddOptEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(GroupAddOptEnum level) => level.index;
}
