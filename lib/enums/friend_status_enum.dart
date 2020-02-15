/// 好友状态枚举
enum FriendStatusEnum {
  /// 操作成功
  SUCC,

  /// 请求参数错误，请根据错误描述检查请求是否正确
  PARAM_INVALID,

  /// 加好友、响应好友时有效：自己的好友数已达系统上限
  SELF_FRIEND_FULL,

  /// 加好友、响应好友时有效：对方的好友数已达系统上限
  THEIR_FRIEND_FULL,

  /// 加好友时有效：被加好友在自己的黑名单中
  IN_SELF_BLACK_LIST,

  /// 加好友时有效：被加好友设置为禁止加好友
  FRIEND_SIDE_FORBID_ADD,

  /// 加好友时有效：已被被添加好友设置为黑名单
  IN_OTHER_SIDE_BLACK_LIST,

  /// 加好友时有效：等待好友审核同意
  PENDING
}

/// 枚举工具
class FriendStatusEnumTool {
  /// 根据数标获得枚举
  static FriendStatusEnum getEnumByIndex(index) {
    switch (index) {
      case 0:
        return FriendStatusEnum.SUCC;
      case 30001:
        return FriendStatusEnum.PARAM_INVALID;
      case 30010:
        return FriendStatusEnum.SELF_FRIEND_FULL;
      case 30014:
        return FriendStatusEnum.THEIR_FRIEND_FULL;
      case 30515:
        return FriendStatusEnum.IN_SELF_BLACK_LIST;
      case 30516:
        return FriendStatusEnum.FRIEND_SIDE_FORBID_ADD;
      case 30525:
        return FriendStatusEnum.IN_OTHER_SIDE_BLACK_LIST;
      case 30539:
        return FriendStatusEnum.PENDING;
      default:
        return null;
    }
  }

  /// 根据枚举获得数标
  static int getIndexByEnum(e) {
    switch (e) {
      case FriendStatusEnum.SUCC:
        return 0;
      case FriendStatusEnum.PARAM_INVALID:
        return 30001;
      case FriendStatusEnum.SELF_FRIEND_FULL:
        return 30010;
      case FriendStatusEnum.THEIR_FRIEND_FULL:
        return 30514;
      case FriendStatusEnum.IN_SELF_BLACK_LIST:
        return 30515;
      case FriendStatusEnum.FRIEND_SIDE_FORBID_ADD:
        return 30516;
      case FriendStatusEnum.IN_OTHER_SIDE_BLACK_LIST:
        return 30525;
      case FriendStatusEnum.PENDING:
        return 30539;
      default:
        return null;
    }
  }
}
