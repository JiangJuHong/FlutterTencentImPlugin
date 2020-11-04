/// 信令操作类型枚举
enum SignalingActionTypeEnum {
  // 邀请方发起邀请
  Invite,
  // 邀请方取消邀请
  Cancel,
  // 被邀请方接受邀请
  Accept,
  // 被邀请方拒绝邀请
  Reject,
  // 邀请超时
  Timeout
}

class SignalingActionTypeTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static SignalingActionTypeEnum getByInt(int index) =>
      SignalingActionTypeEnum.values[index - 1];

  /// 将枚举转换为整型
  static int toInt(SignalingActionTypeEnum level) => level.index + 1;
}
