import 'dart:convert';

import 'package:tencent_im_plugin/enums/download_type_enum.dart';

/// 下载进度实体
class DownloadProgressEntity {
  /// 消息ID
  late String msgId;

  /// 当前下载大小
  late int currentSize;

  /// 总大小
  late int totalSize;

  /// 下载类型
  late DownloadTypeEnum type;

  DownloadProgressEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['msgId'] != null) msgId = json["msgId"];
    if (json['currentSize'] != null) currentSize = json["currentSize"];
    if (json['totalSize'] != null) totalSize = json["totalSize"];
    if (json['type'] != null) type = DownloadTypeTool.getByInt(json["type"]);
  }
}
