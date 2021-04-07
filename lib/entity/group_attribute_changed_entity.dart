import 'dart:convert';

/// 群属性更新实体
class GroupAttributeChangedEntity {
  /// 群ID
  String? groupID;

  /// 群成员列表
  Map<String, String>? attributes;

  GroupAttributeChangedEntity.fromJson(data) {
    Map<String, dynamic> json = data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['groupID'] != null) groupID = json['groupID'];
    if (json['attributes'] != null) attributes = (json["attributes"] as Map).cast<String, String>();
  }
}
