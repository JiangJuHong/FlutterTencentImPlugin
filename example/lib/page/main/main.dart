import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tencent_im_plugin_example/page/main/components/conversation.dart';
import 'package:tencent_im_plugin_example/page/main/components/friend.dart';
import 'package:tencent_im_plugin_example/page/main/components/group.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/entity/group_info_entity.dart';
import 'package:tencent_im_plugin/entity/friend_add_application_entity.dart';
import 'package:tencent_im_plugin/enums/group_type_enum.dart';
import 'package:tencent_im_plugin/enums/friend_type_enum.dart';
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
      this._startConversation();
    } else if (value == 1) {
      this._startGroupChat();
    } else if (value == 2) {
      this._startAddFriend();
    }
  }

  /// 发起会话
  void _startConversation() async {
    String text = "";
    var result = await this._showDialog(
      "发起会话",
      TextField(
        onChanged: (_text) => text = _text,
        decoration: InputDecoration(hintText: "请输入用户ID"),
      ),
    );

    // 执行操作
    if (result && text.trim() != '') {
      TencentImPlugin.sendMessage(node: TextMessageNode(content: "发起对话"), receiver: text);
    }
  }

  /// 开启群聊
  void _startGroupChat() async {
    String text = "";
    GroupTypeEnum type;
    var result = await this._showDialog(
      "创建群聊",
      Column(
        children: [
          TextField(
            onChanged: (_text) => text = _text,
            decoration: InputDecoration(hintText: "请输入群名称"),
          ),
          GroupSelect(title: "群类型", values: GroupTypeEnum.values, onChanged: (newType) => type = newType),
        ],
      ),
    );

    if (result && text != '' && type != null) {
      String id = await TencentImPlugin.createGroup(info: GroupInfoEntity.create(groupName: text, groupType: GroupTypeEnum.Public));
      Fluttertoast.showToast(msg: "群聊创建成功，群ID:$id");
    }
  }

  /// 添加好友
  void _startAddFriend() async {
    String text = "";
    var result = await this._showDialog(
      "添加好友",
      TextField(
        onChanged: (_text) => text = _text,
        decoration: InputDecoration(hintText: "请输入用户ID"),
      ),
    );

    // 执行操作
    if (result && text.trim() != '') {
      TencentImPlugin.addFriend(info: FriendAddApplicationEntity(userID: text, addType: FriendTypeEnum.Both)).then((res) {
        Fluttertoast.showToast(msg: "好友申请发送成功!");
      }).catchError((e) {
        Fluttertoast.showToast(msg: "好友申请发送失败!");
      });
    }
  }

  /// 显示对话框
  /// [title] 标题
  /// [child] 内容
  Future<bool> _showDialog(String title, Widget child) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: child,
        actions: [
          OutlinedButton(
            child: Text("取消"),
            onPressed: () => Navigator.pop(context, false),
          ),
          OutlinedButton(
            child: Text("确定"),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
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
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[Text('创建群聊')],
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[Text('添加好友')],
                ),
                value: 2,
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
              BottomNavigationBarItem(icon: Icon(Icons.supervisor_account), label: "群组"),
              BottomNavigationBarItem(icon: Icon(Icons.account_box), label: "好友"),
            ],
            onTap: _onPageChange,
          ),
        ],
      ),
    );
  }
}

/// 组选择
class GroupSelect<T> extends StatefulWidget {
  /// 标签
  final String title;

  /// 值列表
  final List<T> values;

  /// 改变事件
  final ValueChanged<T> onChanged;

  const GroupSelect({
    Key key,
    @required this.title,
    @required this.values,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _GroupSelectState createState() => _GroupSelectState<T>();
}

class _GroupSelectState<T> extends State<GroupSelect> {
  /// 当前选择值
  T _value;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Text(widget.title),
      items: List.generate(
        widget.values.length,
        (index) {
          T item = widget.values[index];
          return DropdownMenuItem(
            value: item,
            child: Text("${item.toString()}"),
          );
        },
      ),
      value: _value,
      elevation: 1,
      onChanged: (newType) {
        if (widget.onChanged != null) widget.onChanged(newType);
        this._value = newType;
        if (this.mounted) this.setState(() {});
      },
    );
  }
}
