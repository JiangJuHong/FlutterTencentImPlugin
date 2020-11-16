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
      userID: "dev",
      userSig:
          "eJwtzEELgjAYxvHvsnPIu7U5EzoEQRDWITWqW7KVr8MaS8Yi*u6Zenx*D-w-pMjyyGtHUsIiILNho9KPDm84sNJ*4pcyV2tRkZRyALbgc8rHRweLTvcuhGAAMGqH7d9iEAKSWMipgve*ulZS1vKoT83uXO6rkAWzaoqtgVAdNpecu9Y-38aXtE6W5PsDr9ExPw__",
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
