import 'dart:convert';

/// 群接收到REST自定义信息通知实体
class GroupReceiveRESTEntity {
  /// 群ID
  late String groupID;

  /// 自定义数据
  String? customData;

  GroupReceiveRESTEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['groupID'] != null) groupID = json['groupID'];
    if (json['customData'] != null) customData = json['customData'];
  }
}
