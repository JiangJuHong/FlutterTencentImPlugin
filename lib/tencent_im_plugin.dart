import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tencent_im_plugin/list_util.dart';

import 'entity/session_entity.dart';

class TencentImPlugin {
  static const MethodChannel _channel =
      const MethodChannel('tencent_im_plugin');

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

  /// 获得当前登录用户会话列表
  /// @return 会话列表集合
  static Future<List<SessionEntity>> getConversationList() async {
    final String data = await _channel.invokeMethod('getConversationList');
    return ListUtil.generateOBJList<SessionEntity>(jsonDecode(data));
  }

  /// 初始化本地存储
  static Future<void> initStorage({String identifier}) async {
    await _channel.invokeMethod('initStorage', {"identifier": identifier});
  }
}
