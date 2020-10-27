/// 图片类型
enum ImageTypeEnum {
  /// 原图
  Original,

  /// 缩略图
  Thumb,

  /// 大图
  Large,
}

class ImageTypeTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static ImageTypeEnum getByInt(int index) => ImageTypeEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(ImageTypeEnum level) => level.index;
}
