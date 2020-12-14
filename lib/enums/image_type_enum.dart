import 'dart:io';

/// 图片类型
/// 由于腾讯云 Android 和 IOS 的 V2TIMImageType 对象不相同，所以需要单独解析
///   Android 的下标为 0、1、2，IOS的为 1、2、4
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
  static ImageTypeEnum getByInt(int index) {
    // 单独解析Android
    if (Platform.isAndroid) {
      return ImageTypeEnum.values[index];
    }

    switch (index) {
      case 1:
        return ImageTypeEnum.Original;
      case 2:
        return ImageTypeEnum.Thumb;
      case 4:
        return ImageTypeEnum.Large;
    }
    throw ArgumentError("参数异常");
  }

  /// 将枚举转换为整型
  static int toInt(ImageTypeEnum data) {
    // 单独解析Android
    if (Platform.isAndroid) {
      return data.index;
    }

    switch (data) {
      case ImageTypeEnum.Original:
        return 1;
      case ImageTypeEnum.Thumb:
        return 2;
      case ImageTypeEnum.Large:
        return 4;
    }
    throw ArgumentError("参数异常");
  }
}
