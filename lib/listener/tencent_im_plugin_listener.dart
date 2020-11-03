import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tencent_im_plugin/enums/tencent_im_listener_type_enum.dart';
import 'package:tencent_im_plugin/utils/enum_util.dart';

/// 监听器对象
class TencentImPluginListener {
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
          TencentImListenerTypeEnum type = EnumUtil.nameOf(TencentImListenerTypeEnum.values, arguments['type']);
          var paramsStr = arguments['params'];

          // 封装回调类型和参数
          var params;

          switch (type) {
            case TencentImListenerTypeEnum.NewMessage:
              break;
            case TencentImListenerTypeEnum.C2CReadReceipt:
              break;
            case TencentImListenerTypeEnum.MessageRevoked:
              break;
            case TencentImListenerTypeEnum.SyncServerStart:
              break;
            case TencentImListenerTypeEnum.SyncServerFinish:
              break;
            case TencentImListenerTypeEnum.SyncServerFailed:
              break;
            case TencentImListenerTypeEnum.NewConversation:
              break;
            case TencentImListenerTypeEnum.ConversationChanged:
              break;
            case TencentImListenerTypeEnum.FriendApplicationListAdded:
              break;
            case TencentImListenerTypeEnum.FriendApplicationListDeleted:
              break;
            case TencentImListenerTypeEnum.FriendApplicationListRead:
              break;
            case TencentImListenerTypeEnum.FriendListAdded:
              break;
            case TencentImListenerTypeEnum.FriendListDeleted:
              break;
            case TencentImListenerTypeEnum.BlackListAdd:
              break;
            case TencentImListenerTypeEnum.BlackListDeleted:
              break;
            case TencentImListenerTypeEnum.FriendInfoChanged:
              break;
            case TencentImListenerTypeEnum.MemberEnter:
              break;
            case TencentImListenerTypeEnum.MemberLeave:
              break;
            case TencentImListenerTypeEnum.MemberInvited:
              break;
            case TencentImListenerTypeEnum.MemberKicked:
              break;
            case TencentImListenerTypeEnum.MemberInfoChanged:
              break;
            case TencentImListenerTypeEnum.GroupCreated:
              break;
            case TencentImListenerTypeEnum.GroupDismissed:
              break;
            case TencentImListenerTypeEnum.GroupRecycled:
              break;
            case TencentImListenerTypeEnum.GroupInfoChanged:
              break;
            case TencentImListenerTypeEnum.ReceiveJoinApplication:
              break;
            case TencentImListenerTypeEnum.ApplicationProcessed:
              break;
            case TencentImListenerTypeEnum.GrantAdministrator:
              break;
            case TencentImListenerTypeEnum.RevokeAdministrator:
              break;
            case TencentImListenerTypeEnum.QuitFromGroup:
              break;
            case TencentImListenerTypeEnum.ReceiveRESTCustomData:
              break;
            case TencentImListenerTypeEnum.GroupAttributeChanged:
              break;
            case TencentImListenerTypeEnum.Connecting:
              break;
            case TencentImListenerTypeEnum.ConnectSuccess:
              break;
            case TencentImListenerTypeEnum.ConnectFailed:
              break;
            case TencentImListenerTypeEnum.KickedOffline:
              break;
            case TencentImListenerTypeEnum.SelfInfoUpdated:
              break;
            case TencentImListenerTypeEnum.UserSigExpired:
              break;
            case TencentImListenerTypeEnum.ReceiveNewInvitation:
              break;
            case TencentImListenerTypeEnum.InviteeAccepted:
              break;
            case TencentImListenerTypeEnum.InviteeRejected:
              break;
            case TencentImListenerTypeEnum.InvitationCancelled:
              break;
            case TencentImListenerTypeEnum.InvitationTimeout:
              break;
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
typedef TencentImListenerValue<P> = void Function(TencentImListenerTypeEnum type, P params);
