/// 未决类型
enum PendencyTypeEnum {
  /// 别人发给我的未决请求
  COME_IN,

  /// 我发给别人的未决请求
  SEND_OUT,

  /// 别人发给我的以及我发给别人的所有未决请求，仅在拉取时有效。
  BOTH,
}

/// 枚举工具
class PendencyTypeTool {
  /// 根据数标获得枚举
  static PendencyTypeEnum getEnumByIndex(index) {
    switch (index) {
      case 1:
        return PendencyTypeEnum.COME_IN;
      case 2:
        return PendencyTypeEnum.SEND_OUT;
      case 3:
        return PendencyTypeEnum.BOTH;
      default:
        return null;
    }
  }

  /// 根据枚举获得数标
  static int getIndexByEnum(e) {
    switch (e) {
      case PendencyTypeEnum.COME_IN:
        return 1;
      case PendencyTypeEnum.SEND_OUT:
        return 2;
      case PendencyTypeEnum.BOTH:
        return 3;
      default:
        return null;
    }
  }
}
