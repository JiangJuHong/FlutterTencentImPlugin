import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tencent_im_plugin_example/page/main/components/conversation.dart';
import 'package:tencent_im_plugin_example/page/main/components/friend.dart';
import 'package:tencent_im_plugin_example/page/main/components/group.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/message_node/text_message_node.dart';

/// 用户主页
class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  /// 当前页面下标
  int _index = 0;

  /// 页面控制器
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  /// 页面改变事件
  _onPageChange(index) {
    _pageController.jumpToPage(index);
    this.setState(() {
      _index = index;
    });
  }

  /// 菜单点击事件
  _onMenuClick(int value) async {
    if (value == 0) {
      String text = "";

      //显示对话框
      if (await showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text("发起会话"),
              content: TextField(
                onChanged: (_text) => text = _text,
                decoration: InputDecoration(hintText: "请输入用户ID"),
              ),
              actions: [
                FlatButton(
                  child: Text("取消"),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text("确定"),
                  onPressed: () => Navigator.pop(context, true),
                ),
              ],
            ),
          ) &&
          text.trim() != '') {
        TencentImPlugin.sendMessage(
            node: TextMessageNode(content: "发起对话"), receiver: text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("主页"),
        actions: [
          PopupMenuButton<int>(
            onSelected: _onMenuClick,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[Text('发起对话')],
                ),
                value: 0,
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: _onPageChange,
              controller: _pageController,
              children: [
                Conversation(),
                Group(),
                Friend(),
              ],
            ),
          ),
          BottomNavigationBar(
            currentIndex: _index,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.message), label: "会话"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.supervisor_account), label: "群组"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_box), label: "好友"),
            ],
            onTap: _onPageChange,
          ),
        ],
      ),
    );
  }
}
