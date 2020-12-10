import 'dart:convert';
import 'package:tencent_im_plugin/enums/group_application_handler_result_enum.dart';
import 'package:tencent_im_plugin/enums/group_application_handler_status_enum.dart';
import 'package:tencent_im_plugin/enums/group_application_type_enum.dart';

/// 群申请实体
class GroupApplicationEntity {
  /// 群ID
  String groupID;

  /// 获取请求者 ID，请求加群:请求者，邀请加群:邀请人
  String fromUser;

  /// 用户昵称
  String fromUserNickName;

  /// 用户头像
  String fromUserFaceUrl;

  /// 获取处理者 ID, 请求加群:0，邀请加群:被邀请人
  String toUser;

  /// 获取群未决添加的时间，单位：秒
  int addTime;

  /// 获取请求者添加的附加信息
  String requestMsg;

  /// 获取处理者添加的附加信息，只有处理状态不为V2TIMGroupApplication#V2TIM_GROUP_APPLICATION_HANDLE_STATUS_UNHANDLED的时候有效
  String handledMsg;

  /// 获取群未决请求类型
  GroupApplicationTypeEnum type;

  /// 获取群未决处理状态
  GroupApplicationHandlerStatusEnum handleStatus;

  /// 获取群未决处理操作类型，只有处理状态不为V2TIMGroupApplication#V2TIM_GROUP_APPLICATION_HANDLE_STATUS_UNHANDLED的时候有效
  GroupApplicationHandlerResultEnum handleResult;

  GroupApplicationEntity.fromJson(data) {
    Map<String, dynamic> json =
        data is Map ? data.cast<String, dynamic>() : jsonDecode(data);
    groupID = json['groupID'];
    fromUser = json['fromUser'];
    fromUserNickName = json['fromUserNickName'];
    fromUserFaceUrl = json['fromUserFaceUrl'];
    toUser = json['toUser'];
    addTime = json['addTime'];
    requestMsg = json['requestMsg'];
    handledMsg = json['handledMsg'];
    type = GroupApplicationTypeTool.getByInt(json['type']);
    handleStatus =
        GroupApplicationHandlerStatusTool.getByInt(json['handleStatus']);
    handleResult =
        GroupApplicationHandlerResultTool.getByInt(json['handleResult']);
  }
}
