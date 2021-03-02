import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin_example/utils/GenerateTestUserSig.dart';

/// 登录页面
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _controller = TextEditingController();

  /// 用户名
  String _userName = "dev";

  @override
  void initState() {
    super.initState();
    _controller.text = _userName;
  }

  /// 登录按钮点击事件
  _onLogin() async {
    String sign = GenerateTestUserSig(
      sdkappid: 1400294314,
      key: "706da51f9280812611bcc80b5182b1c5554db8d053bc00b8a37ae8cba887f6a7",
    ).genSig(identifier: _userName, expire: 1 * 60 * 1000);

    await TencentImPlugin.login(
      userID: _userName,
      userSig: sign,
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
                controller: _controller,
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
