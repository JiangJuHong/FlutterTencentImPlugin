import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/enums/log_print_level.dart';
import 'package:tencent_im_plugin_example/tencent_im_plugin_example.dart';

import 'page/home.dart';

void main() {
  // 运行程序
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // 设置监听器
    TencentImPluginExample.setListener();
    // 初始化SDK(每次仅调用一次)
    TencentImPlugin.init(appid: "1400294314", logPrintLevel: LogPrintLevel.info);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  /// 登录
  onLogin() async {
    await TencentImPlugin.initStorage(identifier: "dev");

    await TencentImPlugin.login(
      identifier: "dev",
      userSig: "eJyrVgrxCdYrSy1SslIy0jNQ0gHzM1NS80oy0zLBwimpZVDh4pTsxIKCzBQlK0MTAwMjSxNjQxOITGpFQWZRKlDc1NTUyMDAACJakpkLFrOwNLcwtDA3hJqSmQ401aDKpDQw2NnHLSo4yTjR06XAy8XSNyLJsSgt0cjALSQpqNI-syDV2aWw0MJWqRYAm*EwVg__",
    );

    // 注册离线推送
    if(TencentImPluginExample.miPushToken != null){
      await TencentImPlugin.setOfflinePushToken(token: TencentImPluginExample.miPushToken,bussid: 10301);
    }

    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new HomePage()),
    );
  }

  /// 退出登录
  onLogout() {
    TencentImPlugin.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录页面"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: onLogin,
              child: Text("点击登录"),
            ),
            RaisedButton(
              onPressed: onLogout,
              child: Text("退出登录"),
            )
          ],
        ),
      ),
    );
  }
}
