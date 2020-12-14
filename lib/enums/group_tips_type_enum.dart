/// 群组事件通知类型
enum GroupTipsTypeEnum {
  /// 非法
  Invalid,

  /// 主动入群（memberList 加入群组，非 Work 群有效）
  Join,

  /// 被邀请入群（opMember 邀请 memberList 入群，Work 群有效）
  Invite,

  /// 退出群组
  Quit,

  /// 踢出群 (opMember 把 memberList 踢出群组)
  Kicked,

  /// 设置管理员 (opMember 把 memberList 设置为管理员)
  Admin,

  /// 取消管理员 (opMember 取消 memberList 管理员身份)
  CancelAdmin,

  /// 群资料变更 (opMember 修改群资料：groupName & introduction & notification & faceUrl & owner & custom)
  GroupInfoChange,

  /// 群成员资料变更 (opMember 修改群成员资料：muteTime)
  MemberInfoChange,
}

/// 枚举工具
class GroupTipsTypeTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static GroupTipsTypeEnum getByInt(int index) =>
      GroupTipsTypeEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(GroupTipsTypeEnum data) => data.index;
}
