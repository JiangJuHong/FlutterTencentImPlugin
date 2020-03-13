/// 枚举工具类
class EnumUtil {
  /// 获得枚举的名称(不包含前缀)
  static String getEnumName(enumObj) {
    var es = enumObj.toString().split(".");
    return es[es.length - 1];
  }
}
