/// 未决审核类型枚举
enum PendencyExamineTypeEnum {
  // 同意加好友（建立单向好友）
  AGREE,
  // 同意加好友并加对方为好友（建立双向好友）
  AGREE_AND_ADD,
  // 拒绝对方好友请求
  REJECT,
}

/// 枚举工具
class PendencyExamineTypeEnumTool {
  /// 根据数标获得枚举
  static PendencyExamineTypeEnum getEnumByIndex(index) {
    switch (index) {
      case 0:
        return PendencyExamineTypeEnum.AGREE;
      case 1:
        return PendencyExamineTypeEnum.AGREE_AND_ADD;
      case 2:
        return PendencyExamineTypeEnum.REJECT;
      default:
        return null;
    }
  }

  /// 根据枚举获得数标
  static int getIndexByEnum(e) {
    switch (e) {
      case PendencyExamineTypeEnum.AGREE:
        return 0;
      case PendencyExamineTypeEnum.AGREE_AND_ADD:
        return 1;
      case PendencyExamineTypeEnum.REJECT:
        return 2;
      default:
        return null;
    }
  }
}
