import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tencent_im_plugin_example/page/main/components/conversation.dart';
import 'package:tencent_im_plugin_example/page/main/components/friend.dart';
import 'package:tencent_im_plugin_example/page/main/components/group.dart';

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

  /// 页面改变事件
  _onPageChange(index) {
    _pageController.jumpToPage(index);
    this.setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("主页")),
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
