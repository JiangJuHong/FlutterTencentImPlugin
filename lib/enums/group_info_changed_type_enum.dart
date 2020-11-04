/// 群信息改变类型枚举
enum GroupInfoChangedTypeEnum {
  /// 非法值
  Invalid,

  /// 群名
  Name,

  /// 群简介
  Introduction,

  /// 群公告
  Notification,

  /// 群头像
  FaceUrl,

  /// 群主
  Owner,

  /// 自定义字段
  Custom,
}

class GroupInfoChangedTypeTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static GroupInfoChangedTypeEnum getByInt(int index) =>
      GroupInfoChangedTypeEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(GroupInfoChangedTypeEnum level) => level.index;
}
