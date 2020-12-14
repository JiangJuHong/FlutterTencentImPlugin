import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    TencentImPlugin.initSDK(appid: '1400294314');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("页面导航")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, "/interfaces_test"),
              child: Text("接口测试"),
            ),
            RaisedButton(
              onPressed: () => Navigator.pushNamed(context, "/login"),
              child: Text("进入Demo"),
            ),
          ],
        ),
      ),
    );
  }
}
