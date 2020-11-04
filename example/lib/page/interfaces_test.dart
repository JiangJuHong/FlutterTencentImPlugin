import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';

/// 接口测试页面
class InterfacesTest extends StatefulWidget {
  @override
  _InterfacesTestState createState() => _InterfacesTestState();
}

class _InterfacesTestState extends State<InterfacesTest> {
  /// 接口列表
  Map<String, VoidCallback> _interfaces = {
    "initSDK": () => TencentImPlugin.initSDK(appid: '1400294314'),
    // "unInitSDK": () => TencentImPlugin.unInitSDK(),
    "login": () => TencentImPlugin.login(
          userID: "dev",
          userSig: "eJyrVgrxCdYrSy1SslIy0jNQ0gHzM1NS80oy0zLBwimpZVDh4pTsxIKCzBQlK0MTAwMjSxNjQxOITGpFQWZRKlDc1NTUyMDAACJakpkLFrOwNLcwtDA3hJqSmQ401aDKpDQw2NnHLSo4yTjR06XAy8XSNyLJsSgt0cjALSQpqNI-syDV2aWw0MJWqRYAm*EwVg__",
        ),
  };

  /// 当前正在测试的Key
  String _currentTestKey;

  /// 已测试数量
  int _finishTestCount = 0;

  /// 未通过接口列表
  List<String> _failInterfaces = [];

  /// 是否开始测试
  bool _start = false;

  /// 测试结果描述
  List<String> _result = [];

  /// 开始测试
  startTest() async {
    this.setState(() => _start = true);

    var getDateTime = () {
      DateTime dateTime = DateTime.now();
      return "${dateTime.hour <= 9 ? "0${dateTime.hour}" : dateTime.hour}:${dateTime.minute <= 9 ? "0${dateTime.minute}" : dateTime.minute}:${dateTime.second <= 9 ? "0${dateTime.second}" : dateTime.second}";
    };

    for (var key in _interfaces.keys) {
      this.setState(() => _currentTestKey = key);
      try {
        await _interfaces[key]();
        _result.add("${getDateTime()}-[$key]:测试通过");
      } catch (err) {
        _failInterfaces.add("$key : $err");
        _result.add("${getDateTime()}-[$key]:$err");
      }
      this.setState(() => _finishTestCount += 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("接口测试列表")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                text: "接口数量:${_interfaces.length}",
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(text: "，已通过:"),
                  TextSpan(text: "${_finishTestCount - _failInterfaces.length}", style: TextStyle(color: Colors.green)),
                  TextSpan(text: "，未通过:"),
                  TextSpan(text: "${_failInterfaces.length}", style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            _start
                ? Text((_finishTestCount == _interfaces.length) ? "测试完成" : "正在测试:$_currentTestKey")
                : RaisedButton(
                    onPressed: startTest,
                    child: Text("开始测试"),
                  ),
            Divider(),
            Expanded(
                child: ListView(
              children: _result
                  .map(
                    (e) => RichText(
                      text: TextSpan(
                        text: e,
                        style: TextStyle(color: e.endsWith("测试通过") ? Colors.green : Colors.red),
                      ),
                    ),
                  )
                  .toList(),
            )),
          ],
        ),
      ),
    );
  }
}
