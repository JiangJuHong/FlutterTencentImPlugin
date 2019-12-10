import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:tencent_im_plugin/entity/add_friend_result_entity.dart';
import 'package:tencent_im_plugin/entity/check_friend_result_entity.dart';
import 'package:tencent_im_plugin/entity_factory.dart';
import 'package:tencent_im_plugin/list_util.dart';

import 'entity/friend_entity.dart';
import 'entity/group_info_entity.dart';
import 'entity/message_entity.dart';
import 'entity/pendency_entity.dart';
import 'entity/pendency_page_entity.dart';
import 'entity/session_entity.dart';
import 'entity/user_info_entity.dart';
import 'enums/friend_add_type_enum.dart';
import 'enums/friend_check_type_enum.dart';
import 'enums/pendency_examine_type_enum.dart';
import 'enums/pendency_type_enum.dart';

class TencentImPlugin {
  static const MethodChannel _channel =
      const MethodChannel('tencent_im_plugin');

  /// 监听器对象
  static TencentImPluginListener listener;

  /// 初始化腾讯云IM插件
  static Future<void> init({@required String appid}) async {
    await _channel.invokeMethod('init', {"appid": appid});
  }

  /// 登录腾讯云IM
  static Future<void> login(
      {@required String identifier, @required String userSig}) async {
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
  static Future<GroupInfoEntity> getGroupInfo({@required id}) async {
    final String result =
        await _channel.invokeMethod('getGroupInfo', {"id": id});
    if (result != null) {
      return EntityFactory.generateOBJ<GroupInfoEntity>(jsonDecode(result));
    }
    return null;
  }

  /// 获得用户信息
  /// @return 用户ID
  static Future<UserInfoEntity> getUserInfo({@required id}) async {
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
    @required String sessionId,
    @required SessionType sessionType,
    @required int number,
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
    @required String sessionId,
    @required SessionType sessionType,
    @required int number,
  }) async {
    final String data = await _channel.invokeMethod('getLocalMessages', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "number": number,
    });
    return ListUtil.generateOBJList<MessageEntity>(jsonDecode(data));
  }

  /// 初始化本地存储
  static Future<void> initStorage({@required String identifier}) async {
    await _channel.invokeMethod('initStorage', {"identifier": identifier});
  }

  /// 设置会话消息为已读
  static Future<void> setRead({
    @required String sessionId,
    @required SessionType sessionType,
  }) async {
    await _channel.invokeMethod('setRead', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
    });
  }

  /// 发送文本消息
  static Future<void> sendTextMessage({
    @required String sessionId,
    @required SessionType sessionType,
    @required String content,
  }) async {
    await _channel.invokeMethod('sendTextMessage', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "content": content,
    });
  }

  /// 发送语音消息
  static Future<void> sendSoundMessage({
    @required String sessionId,
    @required SessionType sessionType,
    @required String path,
    @required int duration,
  }) async {
    await _channel.invokeMethod('sendSoundMessage', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "path": path,
      "duration": duration,
    });
  }

  /// 发送图片消息
  static Future<void> sendImageMessage({
    @required String sessionId,
    @required SessionType sessionType,
    @required String path,
  }) async {
    await _channel.invokeMethod('sendImageMessage', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "path": path,
    });
  }

  /// 发送视频消息
  static Future<void> sendVideoMessage({
    @required String sessionId,
    @required SessionType sessionType,
    @required String path,
    @required String type,
    @required int duration,
    @required int snapshotWidth,
    @required int snapshotHeight,
    @required String snapshotPath,
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

  /// 获得好友列表
  static Future<List<FriendEntity>> getFriendList() async {
    String data = await _channel.invokeMethod('getFriendList');
    return ListUtil.generateOBJList<FriendEntity>(jsonDecode(data));
  }

  /// 获得群列表
  static Future<List<GroupInfoEntity>> getGroupList() async {
    String data = await _channel.invokeMethod('getGroupList');
    return ListUtil.generateOBJList<GroupInfoEntity>(jsonDecode(data));
  }

  /// 添加好友
  static Future<AddFriendResultEntity> addFriend({
    @required String id,
    String remark,
    String addWording,
    String addSource,
    String friendGroup,
    @required FriendAddTypeEnum addType,
  }) async {
    String data = await _channel.invokeMethod('addFriend', {
      "id": id,
      "remark": remark,
      "addWording": addWording,
      "addSource": addSource,
      "friendGroup": friendGroup,
      "addType":
          addType == null ? null : FriendAddTypeTool.getIndexByEnum(addType),
    });
    return AddFriendResultEntity.fromJson(jsonDecode(data));
  }

  /// 检测单个好友关系
  static Future<CheckFriendResultEntity> checkSingleFriends({
    @required String id,
    @required FriendCheckTypeEnum type,
  }) async {
    String data = await _channel.invokeMethod('checkSingleFriends', {
      "id": id,
      "type": type == null ? null : FriendCheckTypeTool.getIndexByEnum(type),
    });
    return CheckFriendResultEntity.fromJson(jsonDecode(data));
  }

  /// 删除单个好友
//  static Future<CheckFriendResultEntity> removeSingleFriend({
//    @required String id,
//  }) async {
//    String data = await _channel.invokeMethod('removeSingleFriend', {
//      "id": id,
//    });
//    return CheckFriendResultEntity.fromJson(jsonDecode(data));
//  }

  /// 获得未决好友列表
  static Future<PendencyPageEntity> getPendencyList({
    int seq: 0,
    int timestamp: 0,
    int numPerPage: 0,
    @required PendencyTypeEnum type,
  }) async {
    String data = await _channel.invokeMethod('getPendencyList', {
      "type": PendencyTypeTool.getIndexByEnum(type),
      "seq": seq,
      "timestamp": timestamp,
      "numPerPage": numPerPage,
    });
    return EntityFactory.generateOBJ<PendencyPageEntity>(jsonDecode(data));
  }

  /// 设置未决已读
  static Future<void> pendencyReport({
    int timestamp: 0,
  }) async {
    await _channel.invokeMethod('pendencyReport', {
      "timestamp": timestamp,
    });
  }

  /// 未决删除
  static Future<void> deletePendency({
    @required PendencyTypeEnum type,
    @required String id,
  }) async {
    await _channel.invokeMethod('deletePendency', {
      "id": id,
      "type": PendencyTypeTool.getIndexByEnum(type),
    });
  }

  /// 未决审核(通过/拒绝)
  static Future<void> examinePendency({
    @required PendencyExamineTypeEnum type,
    @required String id,
    String remark,
  }) async {
    await _channel.invokeMethod('examinePendency', {
      "id": id,
      "remark": remark,
      "type": PendencyExamineTypeEnumTool.getIndexByEnum(type),
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
