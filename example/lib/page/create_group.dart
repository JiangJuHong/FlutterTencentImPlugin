import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/enums/add_group_opt_enum.dart';
import 'package:tencent_im_plugin/entity/friend_entity.dart';
import 'package:tencent_im_plugin/entity/user_info_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';

/// 创建群聊界面
class CreateGroupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateGroupPageState();
}

class CreateGroupPageState extends State<CreateGroupPage> {
  /// 表单数据对象
  Map<String, dynamic> data = {};

  /// 好友列表
  List<FriendEntity> friendData = [];

  /// 当前登录用户
  UserInfoEntity self;

  @override
  initState() {
    super.initState();
    TencentImPlugin.getFriendList().then((res) {
      friendData = res;
    });

    TencentImPlugin.getSelfProfile().then((res) {
      self = res;
    });
  }

  /// 表单改变
  onChange(key, value) {
    data[key] = value;
    this.setState(() {});
  }

  /// 创建
  onCreate() async {
    String id = await TencentImPlugin.createGroup(
      type: data['type'],
      name: data['name'],
      notification: data['notification'],
      introduction: data['introduction'],
      faceUrl: data['faceUrl'],
      addOption: data['addOption'],
      maxMemberNum: data['maxMemberNum'],
      customInfo: {
        "testTag": 1,
      },
    );

    if (data['type'] == 'Private' && friendData.length >= 1) {
      await TencentImPlugin.inviteGroupMember(
        groupId: id,
        ids: friendData.map((item) => item.identifier).toList(),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("创建群聊")),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Text("群聊类型:"),
            title: DropdownButton(
              value: data["type"],
              onChanged: (value) => onChange("type", value),
              items: <DropdownMenuItem>[
                DropdownMenuItem(
                  child: Text("私有群"),
                  value: "Private",
                ),
                DropdownMenuItem(
                  child: Text("公开群"),
                  value: "Public",
                ),
                DropdownMenuItem(
                  child: Text("聊天室"),
                  value: "ChatRoom",
                ),
                DropdownMenuItem(
                  child: Text("互动直播聊天室"),
                  value: "AVChatRoom",
                ),
              ],
            ),
          ),
          ListTile(
            leading: Text("群聊名称:"),
            title: TextField(
              onChanged: (value) => onChange("name", value),
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          ListTile(
            leading: Text("群聊公告:"),
            title: TextField(
              onChanged: (value) => onChange("notification", value),
              maxLines: 5,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          ListTile(
            leading: Text("群聊简介:"),
            title: TextField(
              onChanged: (value) => onChange("introduction", value),
              maxLines: 5,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          ListTile(
            leading: Text("群聊头像:"),
            title: TextField(
              onChanged: (value) => onChange("faceUrl", value),
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          ListTile(
            leading: Text("加群选项:"),
            title: DropdownButton(
              value: data["addOption"],
              onChanged: (value) => onChange("addOption", value),
              items: <DropdownMenuItem>[
                DropdownMenuItem(
                  child: Text("任何人"),
                  value: AddGroupOptEnum.TIM_GROUP_ADD_ANY,
                ),
                DropdownMenuItem(
                  child: Text("需要管理员审批"),
                  value: AddGroupOptEnum.TIM_GROUP_ADD_AUTH,
                ),
                DropdownMenuItem(
                  child: Text("禁止加群"),
                  value: AddGroupOptEnum.TIM_GROUP_ADD_FORBID,
                ),
              ],
            ),
          ),
          ListTile(
            leading: Text("最大群成员数:"),
            title: TextField(
              onChanged: (value) => onChange(
                "maxMemberNum",
                int.parse(value),
              ),
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          RaisedButton(
            onPressed: onCreate,
            color: Colors.blue,
            child: Text("创建"),
          ),
        ],
      ),
    );
  }
}
