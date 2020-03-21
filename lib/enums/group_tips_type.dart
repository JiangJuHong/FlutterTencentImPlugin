/// 群组事件通知类型
enum GroupTipsType {
  /// 修改成员信息
  AaddGroup,

  /// 取消管理员
  CancelAdmin,

  /// 修改成员信息
  DelGroup,

  /// 非法
  Invalid,

  /// 加入群组
  Join,

  /// 被踢出群组
  Kick,

  /// 修改群资料
  ModifyGroupInfo,

  /// 修改成员信息
  ModifyMemberInfo,

  /// 主动退出群组
  Quit,

  /// 设置管理员
  SetAdmin,
}
