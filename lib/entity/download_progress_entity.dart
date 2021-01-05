import 'dart:convert';

import 'package:tencent_im_plugin/enums/download_type_enum.dart';

/// 下载进度实体
class DownloadProgressEntity {
  /// 消息ID
  String msgId;

  /// 当前下载大小
  int currentSize;

  /// 总大小
  int totalSize;

  /// 下载类型
  DownloadTypeEnum type;

  DownloadProgressEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    msgId = json["msgId"];
    currentSize = json["currentSize"];
    totalSize = json["totalSize"];
    type = DownloadTypeTool.getByInt(json["type"]);
  }
}
