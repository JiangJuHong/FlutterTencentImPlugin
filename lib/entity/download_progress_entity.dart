/// 下载进度实体
class DownloadProgressEntity {
  /// 消息ID
  String msgId;

  /// 当前下载大小
  int currentSize;

  /// 总大小
  int totalSize;

  DownloadProgressEntity.fromJson(Map<String, dynamic> json) {
    msgId = json["msgId"];
    currentSize = json["currentSize"];
    totalSize = json["totalSize"];
  }
}
