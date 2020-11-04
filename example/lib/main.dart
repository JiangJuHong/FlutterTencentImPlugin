import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/message_node/text_message_node.dart';

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
    TencentImPlugin.initSDK(appid: "1400294314");
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
  @override
  void initState() {
    super.initState();
    TencentImPlugin.login(
      userID: "dev",
      userSig:
          "eJyrVgrxCdYrSy1SslIy0jNQ0gHzM1NS80oy0zLBwimpZVDh4pTsxIKCzBQlK0MTAwMjSxNjQxOITGpFQWZRKlDc1NTUyMDAACJakpkLFrOwNLcwtDA3hJqSmQ401aDKpDQw2NnHLSo4yTjR06XAy8XSNyLJsSgt0cjALSQpqNI-syDV2aWw0MJWqRYAm*EwVg__",
    ).then((_) {
      print("登录成功!");
      TencentImPlugin.sendMessage(
          groupID: "@TGS#16XLZ2SG6", node: TextMessageNode(content: "1433223"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录页面"),
      ),
      body: Center(),
    );
  }
}
