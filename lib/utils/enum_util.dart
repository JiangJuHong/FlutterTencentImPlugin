/// 枚举工具类
class EnumUtil {
  /// 获得枚举的名称(不包含前缀)
  static String getEnumName(enumObj) {
    var es = enumObj.toString().split(".");
    return es[es.length - 1];
  }

  /// 根据名字获得枚举
  static T nameOf<T>(List<T> array, String name) {
    for (var item in array) {
      if (EnumUtil.getEnumName(item) == name) {
        return item;
      }
    }
    return null;
  }
}
