/// 关系链变更类型
enum SnsTipsType {
  /// 未知
  INVALID,

  /// 增加好友消息
  ADD_FRIEND,

  /// 删除好友
  DEL_FRIEND,

  /// 增加好友申请
  ADD_FRIEND_REQ,

  /// 删除好友申请
  DEL_FRIEND_REQ,

  /// 添加黑名单
  ADD_BLACKLIST,

  /// 删除黑名单
  DEL_BLACKLIST,

  /// 未决已读上报
  PENDENCY_REPORT,

  /// 关系链资料变更
  SNS_PROFILE_CHANGE,

  /// 推荐数据增加
  ADD_RECOMMEND,

  /// 推荐数据减少
  DEL_RECOMMEND,

  /// 已决增加
  ADD_DECIDE,

  /// 已决减少
  DEL_DECIDE,

  /// 推荐已读上报
  RECOMMEND_REPORT,

  /// 已决已读上报
  DECIDE_REPORT
}
