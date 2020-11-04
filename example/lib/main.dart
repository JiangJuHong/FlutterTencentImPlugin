import 'package:flutter/material.dart';
import 'package:tencent_im_plugin_example/page/home.dart';
import 'package:tencent_im_plugin_example/page/interfaces_test.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => HomePage(),
        "/interfaces_test": (context) => InterfacesTest(),
      },
    );
  }
}
