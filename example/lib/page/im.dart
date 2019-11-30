import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 聊天页面
class ImPage extends StatefulWidget {
  /// 会话ID
  final String id;

  const ImPage({Key key, this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ImPageState();
}

class ImPageState extends State<ImPage> {
  TextEditingController controller = TextEditingController();

  /// 发送事件
  onSend() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.grey,
              width: 1,
            )),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      hintText: "请输入需要发送的内容",
                    ),
                  ),
                ),
                Container(
                  child: RaisedButton(
                    onPressed: onSend,
                    child: Text("发送"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
