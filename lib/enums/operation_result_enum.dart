/// 操作结果枚举
enum OperationResultEnum {
  /// 操作失败
  Fail,

  /// 操作成功
  Succ,

  /// 无效操作
  Invalid,

  /// 等待处理
  Pending,
}

class OperationResultTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static OperationResultEnum getByInt(int index) =>
      OperationResultEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(OperationResultEnum level) => level.index;
}
