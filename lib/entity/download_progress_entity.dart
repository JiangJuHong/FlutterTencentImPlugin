import 'dart:convert';

/// 下载进度实体
class DownloadProgressEntity {
  /// 消息ID
  String msgId;

  /// 当前下载大小
  int currentSize;

  /// 总大小
  int totalSize;

  DownloadProgressEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    msgId = json["msgId"];
    currentSize = json["currentSize"];
    totalSize = json["totalSize"];
  }
}
