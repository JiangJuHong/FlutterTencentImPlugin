import 'package:flutter/services.dart';

class TencentImPluginExample {
  static const MethodChannel _channel = const MethodChannel('tencent_im_plugin_example');

  /// 小米推送TOken
  static String miPushToken;

  /// 设置监听器
  static setListener(){
    _channel.setMethodCallHandler((call) {
      if (call.method == 'miPushTokenListener') {
        miPushToken = call.arguments as String;
      }
      return null;
    });
  }
}
