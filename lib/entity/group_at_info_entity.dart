import 'dart:convert';
import 'package:tencent_im_plugin/enums/group_at_type_enum.dart';

/// 群@信息实体
class GroupAtInfoEntity {
  /// Seq序列号
  int seq;

  /// @类型
  GroupAtTypeEnum atType;

  GroupAtInfoEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    seq = json["seq"];
    atType = GroupAtTypeTool.getByInt(json["atType"]);
  }
}
