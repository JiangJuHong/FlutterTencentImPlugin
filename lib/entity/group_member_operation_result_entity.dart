import 'package:tencent_im_plugin/enums/operation_result_enum.dart';

/// 群成员操作结果实体
class GroupMemberOperationResultEntity {
  /// 操作结果
  OperationResultEnum result;

  /// 群成员ID
  String memberID;

  GroupMemberOperationResultEntity.fromJson(Map<String, dynamic> json) {
    result = OperationResultTool.getByInt(json['result']);
    memberID = json['memberID'];
  }
}
