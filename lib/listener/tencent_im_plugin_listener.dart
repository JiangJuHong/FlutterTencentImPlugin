import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:tencent_im_plugin/entity/conversation_entity.dart';
import 'package:tencent_im_plugin/entity/download_progress_entity.dart';
import 'package:tencent_im_plugin/entity/error_entity.dart';
import 'package:tencent_im_plugin/entity/friend_application_entity.dart';
import 'package:tencent_im_plugin/entity/friend_info_entity.dart';
import 'package:tencent_im_plugin/entity/group_administrator_op_entity.dart';
import 'package:tencent_im_plugin/entity/group_application_processed_entity.dart';
import 'package:tencent_im_plugin/entity/group_attribute_changed_entity.dart';
import 'package:tencent_im_plugin/entity/group_changed_entity.dart';
import 'package:tencent_im_plugin/entity/group_dismissed_or_recycled_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_changed_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_enter_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_invited_or_kicked_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_leave_entity.dart';
import 'package:tencent_im_plugin/entity/group_receive_join_application_entity.dart';
import 'package:tencent_im_plugin/entity/group_receive_rest_entity.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/entity/message_receipt_entity.dart';
import 'package:tencent_im_plugin/entity/message_send_fail_entity.dart';
import 'package:tencent_im_plugin/entity/message_send_progress_entity.dart';
import 'package:tencent_im_plugin/entity/signaling_common_entity.dart';
import 'package:tencent_im_plugin/entity/user_entity.dart';
import 'package:tencent_im_plugin/enums/tencent_im_listener_type_enum.dart';
import 'package:tencent_im_plugin/list_util.dart';
import 'package:tencent_im_plugin/utils/enum_util.dart';

/// 监听器对象
class TencentImPluginListener {
  /// 日志对象
  static Logger _logger = Logger();

  /// 监听器列表
  static Set<TencentImListenerValue> listeners = Set();

  TencentImPluginListener(MethodChannel channel) {
    // 绑定监听器
    channel.setMethodCallHandler((methodCall) async {
      // 解析参数
      Map<String, dynamic> arguments = jsonDecode(methodCall.arguments);

      switch (methodCall.method) {
        case 'onListener':
          // 获得原始类型和参数
          TencentImListenerTypeEnum type = EnumUtil.nameOf(
              TencentImListenerTypeEnum.values, arguments['type']);
          var originalParams = arguments['params'];

          // 封装回调类型和参数
          var params = originalParams;

          try {
            switch (type) {
              case TencentImListenerTypeEnum.NewMessage:
                params = MessageEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.C2CReadReceipt:
                params = ListUtil.generateOBJList<MessageReceiptEntity>(
                    originalParams);
                break;
              case TencentImListenerTypeEnum.MessageRevoked:
                params = originalParams;
                break;
              case TencentImListenerTypeEnum.SyncServerStart:
                break;
              case TencentImListenerTypeEnum.SyncServerFinish:
                break;
              case TencentImListenerTypeEnum.SyncServerFailed:
                break;
              case TencentImListenerTypeEnum.NewConversation:
                params = ListUtil.generateOBJList<ConversationEntity>(
                    originalParams);
                break;
              case TencentImListenerTypeEnum.ConversationChanged:
                params = ListUtil.generateOBJList<ConversationEntity>(
                    originalParams);
                break;
              case TencentImListenerTypeEnum.FriendApplicationListAdded:
                params = ListUtil.generateOBJList<FriendApplicationEntity>(
                    originalParams);
                break;
              case TencentImListenerTypeEnum.FriendApplicationListDeleted:
                break;
              case TencentImListenerTypeEnum.FriendApplicationListRead:
                break;
              case TencentImListenerTypeEnum.FriendListAdded:
                params =
                    ListUtil.generateOBJList<FriendInfoEntity>(originalParams);
                break;
              case TencentImListenerTypeEnum.FriendListDeleted:
                break;
              case TencentImListenerTypeEnum.BlackListAdd:
                params =
                    ListUtil.generateOBJList<FriendInfoEntity>(originalParams);
                break;
              case TencentImListenerTypeEnum.BlackListDeleted:
                break;
              case TencentImListenerTypeEnum.FriendInfoChanged:
                params =
                    ListUtil.generateOBJList<FriendInfoEntity>(originalParams);
                break;
              case TencentImListenerTypeEnum.MemberEnter:
                params = GroupMemberEnterEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.MemberLeave:
                params = GroupMemberLeaveEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.MemberInvited:
                params =
                    GroupMemberInvitedOrKickedEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.MemberKicked:
                params =
                    GroupMemberInvitedOrKickedEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.MemberInfoChanged:
                params = GroupMemberChangedEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.GroupCreated:
                break;
              case TencentImListenerTypeEnum.GroupDismissed:
                params =
                    GroupDismissedOrRecycledEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.GroupRecycled:
                params =
                    GroupDismissedOrRecycledEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.GroupInfoChanged:
                params = GroupChangedEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.ReceiveJoinApplication:
                params =
                    GroupReceiveJoinApplicationEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.ApplicationProcessed:
                params =
                    GroupApplicationProcessedEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.GrantAdministrator:
                params = GroupAdministratorOpEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.RevokeAdministrator:
                params = GroupAdministratorOpEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.QuitFromGroup:
                break;
              case TencentImListenerTypeEnum.ReceiveRESTCustomData:
                params = GroupReceiveRESTEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.GroupAttributeChanged:
                params = GroupAttributeChangedEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.Connecting:
                break;
              case TencentImListenerTypeEnum.ConnectSuccess:
                break;
              case TencentImListenerTypeEnum.ConnectFailed:
                params = ErrorEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.KickedOffline:
                break;
              case TencentImListenerTypeEnum.SelfInfoUpdated:
                params = UserEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.UserSigExpired:
                break;
              case TencentImListenerTypeEnum.ReceiveNewInvitation:
                params = SignalingCommonEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.InviteeAccepted:
                params = SignalingCommonEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.InviteeRejected:
                params = SignalingCommonEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.InvitationCancelled:
                params = SignalingCommonEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.InvitationTimeout:
                params = SignalingCommonEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.DownloadProgress:
                params = DownloadProgressEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.MessageSendSucc:
                params = MessageEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.MessageSendFail:
                params = MessageSendFailEntity.fromJson(originalParams);
                break;
              case TencentImListenerTypeEnum.MessageSendProgress:
                params = MessageSendProgressEntity.fromJson(originalParams);
                break;
            }
          } catch (err) {
            _logger.e(err,
                "$type 监听器错误:$err，请联系开发者进行处理！Github Issues: https://github.com/JiangJuHong/FlutterTencentImPlugin/issues");
          }

          // 没有找到类型就返回
          if (type == null) {
            throw MissingPluginException();
          }

          // 回调触发
          for (var item in listeners) {
            item(type, params);
          }

          break;
        default:
          throw MissingPluginException();
      }
    });
  }

  /// 添加消息监听
  void addListener(TencentImListenerValue func) {
    listeners.add(func);
  }

  /// 移除消息监听
  void removeListener(TencentImListenerValue func) {
    listeners.remove(func);
  }
}

/// 监听器值模型
typedef TencentImListenerValue<P> = void Function(
    TencentImListenerTypeEnum type, P params);
