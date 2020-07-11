/// 群系统提示类型
enum GroupSystemType {
  INVALID,
  ADD_GROUP_REQUEST_TYPE,
  ADD_GROUP_ACCEPT_TYPE,
  ADD_GROUP_REFUSE_TYPE,
  KICK_OFF_FROM_GROUP_TYPE,
  DELETE_GROUP_TYPE,
  CREATE_GROUP_TYPE,
  INVITED_TO_GROUP_TYPE,
  QUIT_GROUP_TYPE,
  GRANT_ADMIN_TYPE,
  CANCEL_ADMIN_TYPE,
  REVOKE_GROUP_TYPE,
  INVITE_TO_GROUP_REQUEST_TYPE,
  INVITATION_ACCEPTED_TYPE,
  INVITATION_REFUSED_TYPE,
  CUSTOM_INFO,
}

class GroupSystemTypeTool {
  /// 根据int值获得枚举类型
  static GroupSystemType intToGroupSystemType(int value) {
    switch (value) {
      case 0:
        return GroupSystemType.INVALID;
      case 1:
        return GroupSystemType.ADD_GROUP_REQUEST_TYPE;
      case 2:
        return GroupSystemType.ADD_GROUP_ACCEPT_TYPE;
      case 3:
        return GroupSystemType.ADD_GROUP_REFUSE_TYPE;
      case 4:
        return GroupSystemType.KICK_OFF_FROM_GROUP_TYPE;
      case 5:
        return GroupSystemType.DELETE_GROUP_TYPE;
      case 6:
        return GroupSystemType.CREATE_GROUP_TYPE;
      case 7:
        return GroupSystemType.INVITED_TO_GROUP_TYPE;
      case 8:
        return GroupSystemType.QUIT_GROUP_TYPE;
      case 9:
        return GroupSystemType.GRANT_ADMIN_TYPE;
      case 10:
        return GroupSystemType.CANCEL_ADMIN_TYPE;
      case 11:
        return GroupSystemType.REVOKE_GROUP_TYPE;
      case 12:
        return GroupSystemType.INVITE_TO_GROUP_REQUEST_TYPE;
      case 13:
        return GroupSystemType.INVITATION_ACCEPTED_TYPE;
      case 14:
        return GroupSystemType.INVITATION_REFUSED_TYPE;
      case 255:
        return GroupSystemType.CUSTOM_INFO;
    }
    return null;
  }
}
