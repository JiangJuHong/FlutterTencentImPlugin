import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/enums/log_print_level.dart';

import 'page/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    // 初始化SDK
    await TencentImPlugin.init(
        appid: "1400290273", logPrintLevel: LogPrintLevel.info);
    // 初始化本地存储
    await TencentImPlugin.initStorage(
        identifier: "98a6f9541f1b455480bf460aa5208497");
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
    await TencentImPlugin.initStorage(identifier: "98a6f9541f1b455480bf460aa5208497");

    await TencentImPlugin.login(
      identifier: "98a6f9541f1b455480bf460aa5208497",
      userSig:
      "eJwtjcsOgjAURP*lWwy5Lb3QkrjxtTDEhRgS3ZXQSiHKQ0SN8d8lwHLO5Mx8ySmK3V63JCTMBbIYs830vbPGjlgK5RuJnBqackQuIDXcB6WQgeAymJ1HVqq6thkJKQdgEljgTY1*17bVA0ccFICJdvY2MuEFSBnj84q9DpfbrtoUptrnziXZlcn62GDhNLU8Q9HLuM0DWB2en0ggvJbk9wfJKDdD",
    );

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
