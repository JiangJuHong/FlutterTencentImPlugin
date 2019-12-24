import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tencent_im_plugin_example/page/create_group.dart';
import 'package:tencent_im_plugin_example/page/friend_list.dart';
import 'package:tencent_im_plugin_example/page/group_list.dart';
import 'package:tencent_im_plugin_example/page/im_list.dart';

import 'apply_list.dart';

/// 首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<NavigationBarData> data = [
    NavigationBarData(
      widget: ImList(),
      title: "会话",
      selectedIcon: Icon(Icons.message),
      unselectedIcon: Icon(Icons.message),
    ),
    NavigationBarData(
      widget: FriendList(),
      title: "好友",
      selectedIcon: Icon(Icons.supervised_user_circle),
      unselectedIcon: Icon(Icons.supervised_user_circle),
    ),
    NavigationBarData(
      widget: ApplyList(),
      title: "申请列表",
      selectedIcon: Icon(Icons.find_replace),
      unselectedIcon: Icon(Icons.find_replace),
    ),
    NavigationBarData(
      widget: GroupList(),
      title: "群组",
      selectedIcon: Icon(Icons.group),
      unselectedIcon: Icon(Icons.group),
    ),
  ];

  /// 当前选择下标
  int currentIndex = 0;

  ///关闭
  close() {
    Navigator.of(context).pop();
  }

  //如果点击的导航页不是当前项，切换
  void _changePage(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
        actions: <Widget>[
          currentIndex == 3
              ? IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: '创建群聊',
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => CreateGroupPage()),
                    );
                  },
                )
              : Container()
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: data.map((res) => res.widget).toList(),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: List.generate(
            data.length,
            (index) => BottomNavigationBarItem(
                  icon: index == currentIndex
                      ? data[index].selectedIcon
                      : data[index].unselectedIcon,
                  title: Text(
                    data[index].title,
                    style: TextStyle(fontFamily: "苹方-中黑体"),
                  ),
                )),
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _changePage(index);
        },
        selectedItemColor: Color(0xFFFF764BF8),
        unselectedItemColor: Color(0xFFFF90939A),
      ),
    );
  }
}

/// 底部导航栏数据对象
class NavigationBarData {
  /// 未选择时候的图标
  final Widget unselectedIcon;

  /// 选择后的图标
  final Widget selectedIcon;

  /// 标题内容
  final String title;

  /// 页面组件
  final Widget widget;

  NavigationBarData({
    this.unselectedIcon,
    this.selectedIcon,
    @required this.title,
    @required this.widget,
  });
}
