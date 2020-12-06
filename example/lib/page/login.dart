import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';

/// 登录页面
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  /// 用户名
  String _userName = "";

  /// 登录按钮点击事件
  _onLogin() async {
    await TencentImPlugin.login(
      userID: "test",
      userSig:
          "eJwtzEELgjAYxvHvsmsh7*ZWKnTooAhFBxPKbpNNe5nK0BFh9N0z9fj8Hvh-SH6*ei-dk4gwD8h23qh057DCmZ0e3OqDMtJaVCSiHICF3Kd8efTbYq8nF0IwAFjUYfu3HQgBQRjs1wrWU3bk7YaepEyPXVIXz3tjzOPWZL422ZjmhYrLi4kTaVkFB-L9Af1dMWQ_",
    );

    Navigator.pushNamedAndRemoveUntil(
        context, "/main", (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录页面"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(hintText: "请输入用户名"),
                textAlign: TextAlign.center,
                onChanged: (value) => this.setState(() => _userName = value),
              ),
              Container(height: 20),
              RaisedButton(
                onPressed: _userName.trim() == '' ? null : _onLogin,
                child: Text("立即登录"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
