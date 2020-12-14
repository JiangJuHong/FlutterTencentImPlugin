import 'dart:convert';
import 'package:tencent_im_plugin/enums/operation_result_enum.dart';

/// 群成员操作结果实体
class GroupMemberOperationResultEntity {
  /// 操作结果
  OperationResultEnum result;

  /// 群成员ID
  String memberID;

  GroupMemberOperationResultEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    result = OperationResultTool.getByInt(json['result']);
    memberID = json['memberID'];
  }
}
