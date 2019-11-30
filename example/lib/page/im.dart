import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';

/// 聊天页面
class ImPage extends StatefulWidget {
  /// 会话ID
  final String id;

  /// 会话类型
  final SessionType type;

  const ImPage({
    Key key,
    this.id,
    this.type,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ImPageState();
}

class ImPageState extends State<ImPage> {
  TextEditingController controller = TextEditingController();

  @override
  initState() {
    super.initState();
    if (widget.type == SessionType.Group) {
      TencentImPlugin.getGroupInfo(id: widget.id);
    } else if (widget.type == SessionType.C2C) {
      TencentImPlugin.getUserInfo(id: widget.id);
    }
  }

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
