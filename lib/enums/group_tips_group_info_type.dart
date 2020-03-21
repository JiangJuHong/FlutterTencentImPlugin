/// 群资料变更消息类型
enum GroupTipsGroupInfoType {
  /// 非法值
  Invalid,

  /// 修改群名称
  ModifyName,

  /// 修改群简介
  ModifyIntroduction,

  /// 修改群公告
  ModifyNotification,

  /// 修改群头像URL
  ModifyFaceUrl,

  /// 修改群主
  ModifyOwner,

  /// 修改群自定义字段
  ModifyCustom,
}
