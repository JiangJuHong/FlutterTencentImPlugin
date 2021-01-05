/// 下载类型枚举
enum DownloadTypeEnum {
  /// 语音
  Sound,

  /// 视频
  Video,

  /// 视频缩略图
  VideoThumbnail,
}

class DownloadTypeTool {
  /// 根据Int类型值获得枚举
  /// [index] Int常量
  /// [Return] 枚举对象
  static DownloadTypeEnum getByInt(int index) =>
      DownloadTypeEnum.values[index];

  /// 将枚举转换为整型
  static int toInt(DownloadTypeEnum level) => level.index;
}
