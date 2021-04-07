import 'dart:convert';
import 'package:tencent_im_plugin/enums/operation_result_enum.dart';

/// 群成员操作结果实体
class GroupMemberOperationResultEntity {
  /// 操作结果
  late OperationResultEnum result;

  /// 群成员ID
  late String memberID;

  GroupMemberOperationResultEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    if (json['result'] != null)
      result = OperationResultTool.getByInt(json['result']);
    if (json['memberID'] != null) memberID = json['memberID'];
  }
}
