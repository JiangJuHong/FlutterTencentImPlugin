import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:tencent_im_plugin/entity_factory.dart';
import 'package:tencent_im_plugin/list_util.dart';

import 'entity/group_info_entity.dart';
import 'entity/message_entity.dart';
import 'entity/session_entity.dart';
import 'entity/user_info_entity.dart';

class TencentImPlugin {
  static const MethodChannel _channel =
      const MethodChannel('tencent_im_plugin');

  /// 监听器对象
  static TencentImPluginListener listener;

  /// 初始化腾讯云IM插件
  static Future<void> init({String appid}) async {
    await _channel.invokeMethod('init', {"appid": appid});
  }

  /// 登录腾讯云IM
  static Future<void> login({String identifier, String userSig}) async {
    await _channel
        .invokeMethod('login', {"identifier": identifier, "userSig": userSig});
  }

  /// 退出登录腾讯云IM
  static Future<void> logout() async {
    await _channel.invokeMethod('logout');
  }

  /// 获得当前登录用户
  /// @return 登录用户ID
  static Future<String> getLoginUser() async {
    final String id = await _channel.invokeMethod('getLoginUser');
    return id;
  }

  /// 获得群信息
  /// @return 群ID
  static Future<GroupInfoEntity> getGroupInfo({id}) async {
    final String result =
        await _channel.invokeMethod('getGroupInfo', {"id": id});
    if (result != null) {
      return EntityFactory.generateOBJ<GroupInfoEntity>(jsonDecode(result));
    }
    return null;
  }

  /// 获得用户信息
  /// @return 用户ID
  static Future<UserInfoEntity> getUserInfo({id}) async {
    final String result =
        await _channel.invokeMethod('getUserInfo', {"id": id});
    if (result != null) {
      return EntityFactory.generateOBJ<UserInfoEntity>(jsonDecode(result));
    }
    return null;
  }

  /// 获得当前登录用户信息
  /// @return 用户ID
  static Future<UserInfoEntity> getLoginUserInfo() async {
    final String result = await _channel.invokeMethod('getLoginUserInfo');
    if (result != null) {
      return EntityFactory.generateOBJ<UserInfoEntity>(jsonDecode(result));
    }
    return null;
  }

  /// 获得当前登录用户会话列表
  /// @return 会话列表集合
  static Future<List<SessionEntity>> getConversationList() async {
    final String data = await _channel.invokeMethod('getConversationList');
    return ListUtil.generateOBJList<SessionEntity>(jsonDecode(data));
  }

  /// 根据会话ID获得消息列表
  /// @param sessionId 会话ID
  /// @param sessionType 会话类型
  /// @param number 拉取消息数量
  /// @return 消息列表集合
  static Future<List<MessageEntity>> getMessages({
    String sessionId,
    SessionType sessionType,
    int number,
  }) async {
    final String data = await _channel.invokeMethod('getMessages', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "number": number,
    });
    return ListUtil.generateOBJList<MessageEntity>(jsonDecode(data));
  }

  /// 根据会话ID获得本地消息列表
  /// @param sessionId 会话ID
  /// @param sessionType 会话类型
  /// @param number 拉取消息数量
  /// @return 消息列表集合
  static Future<List<MessageEntity>> getLocalMessages({
    String sessionId,
    SessionType sessionType,
    int number,
  }) async {
    final String data = await _channel.invokeMethod('getLocalMessages', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "number": number,
    });
    return ListUtil.generateOBJList<MessageEntity>(jsonDecode(data));
  }

  /// 初始化本地存储
  static Future<void> initStorage({String identifier}) async {
    await _channel.invokeMethod('initStorage', {"identifier": identifier});
  }

  /// 设置会话消息为已读
  static Future<void> setRead({
    String sessionId,
    SessionType sessionType,
  }) async {
    await _channel.invokeMethod('setRead', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
    });
  }

  /// 发送文本消息
  static Future<void> sendTextMessage(
      {String sessionId, SessionType sessionType, String content}) async {
    await _channel.invokeMethod('sendTextMessage', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "content": content,
    });
  }

  /// 发送语音消息
  static Future<void> sendSoundMessage(
      {String sessionId,
      SessionType sessionType,
      String path,
      int duration}) async {
    await _channel.invokeMethod('sendSoundMessage', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "path": path,
      "duration": duration,
    });
  }

  /// 发送图片消息
  static Future<void> sendImageMessage({
    String sessionId,
    SessionType sessionType,
    String path,
  }) async {
    await _channel.invokeMethod('sendImageMessage', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "path": path,
    });
  }

  /// 发送视频消息
  static Future<void> sendVideoMessage({
    String sessionId,
    SessionType sessionType,
    String path,
    String type,
    int duration,
    int snapshotWidth,
    int snapshotHeight,
    String snapshotPath,
  }) async {
    await _channel.invokeMethod('sendVideoMessage', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "path": path,
      "type": type,
      "duration": duration,
      "snapshotWidth": snapshotWidth,
      "snapshotHeight": snapshotHeight,
      "snapshotPath": snapshotPath,
    });
  }

  /// 添加消息监听
  static void addListener(ListenerValue func) {
    if (listener == null) {
      listener = TencentImPluginListener(_channel);
    }
    listener.addListener(func);
  }

  /// 移除消息监听
  static void removeListener(ListenerValue func) {
    if (listener == null) {
      listener = TencentImPluginListener(_channel);
    }
    listener.removeListener(func);
  }
}

/// 监听器对象
class TencentImPluginListener {
  /// 监听器列表
  static Set<ListenerValue> listeners = Set();

  TencentImPluginListener(MethodChannel channel) {
    // 绑定监听器
    channel.setMethodCallHandler((methodCall) async {
      // 解析参数
      Map<String, dynamic> arguments = jsonDecode(methodCall.arguments);

      switch (methodCall.method) {
        case 'onListener':
          // 获得原始类型和参数
          String typeStr = arguments['type'];
          String paramsStr = arguments['params'];

          // 封装回调类型和参数
          ListenerTypeEnum type;
          Object params;

          // 初始化类型
          for (var item in ListenerTypeEnum.values) {
            if (item.toString().replaceFirst("ListenerTypeEnum.", "") ==
                typeStr) {
              type = item;
              break;
            }
          }

          // 没有找到类型就返回
          if (type == null) {
            throw MissingPluginException();
          }

          // 根据类型初始化参数
          if (type == ListenerTypeEnum.NewMessages) {
            params =
                ListUtil.generateOBJList<MessageEntity>(jsonDecode(paramsStr));
          } else if (type == ListenerTypeEnum.RefreshConversation) {
            params =
                ListUtil.generateOBJList<SessionEntity>(jsonDecode(paramsStr));
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
  void addListener(ListenerValue func) {
    listeners.add(func);
  }

  /// 移除消息监听
  void removeListener(ListenerValue func) {
    listeners.remove(func);
  }
}

/// 监听器值模型
typedef ListenerValue<P> = void Function(ListenerTypeEnum type, P params);

/// 监听器类型枚举
enum ListenerTypeEnum {
  /// 被踢下线
  ForceOffline,

  /// 用户签名过期，需要重新登录
  UserSigExpired,

  /// 连接
  Connected,

  /// 断开连接
  Disconnected,

  /// Wifi需要认证
  WifiNeedAuth,

  /// 会话刷新
  Refresh,

  /// 会话刷新
  RefreshConversation,

  /// 消息撤回
  MessageRevoked,

  /// 新消息通知
  NewMessages,

  /// 群消息
  GroupTips,

  /// 下载开始
  DownloadStart,

  /// 下载成功
  DownloadSuccess,

  /// 下载失败
  DownloadFail
}
