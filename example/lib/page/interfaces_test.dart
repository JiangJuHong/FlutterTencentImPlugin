import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/utils/enum_util.dart';
import 'package:tencent_im_plugin/entity/group_info_entity.dart';
import 'package:tencent_im_plugin/entity/signaling_info_entity.dart';
import 'package:tencent_im_plugin/entity/user_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/entity/friend_info_entity.dart';
import 'package:tencent_im_plugin/entity/friend_add_application_entity.dart';
import 'package:tencent_im_plugin/message_node/text_message_node.dart';
import 'package:tencent_im_plugin/enums/signaling_action_type_enum.dart';
import 'package:tencent_im_plugin/enums/group_receive_message_opt_enum.dart';
import 'package:tencent_im_plugin/enums/group_member_role_enum.dart';
import 'package:tencent_im_plugin/enums/group_type_enum.dart';
import 'package:tencent_im_plugin/enums/friend_type_enum.dart';
import 'package:logger/logger.dart';

typedef TestCallback = Future<dynamic> Function();

/// 接口测试页面
class InterfacesTest extends StatefulWidget {
  @override
  _InterfacesTestState createState() => _InterfacesTestState();
}

class _InterfacesTestState extends State<InterfacesTest> {
  /// 日志输出
  static Logger _logger = Logger();

  /// 群ID
  static String _groupId = "@TGS#2HAKW7YGC";

  /// 直播群ID
  static String _avGroupId = "@TGS#aRXCQ7YGG";

  /// 好友ID
  static String _friendId = "test";

  /// 接口列表
  Map<String, TestCallback> _interfaces = {
    "getLoginStatus": () => TencentImPlugin.getLoginStatus(),
    "getLoginUser": () => TencentImPlugin.getLoginUser(),
    "invite": () =>
        TencentImPlugin.invite(data: "邀请你进行视频通话1", invitee: _friendId),
    "inviteInGroup": () => TencentImPlugin.inviteInGroup(
        data: "邀请你进行视频通话2", groupID: _groupId, inviteeList: [_friendId]),
    "cancel": () async => TencentImPlugin.cancel(
        inviteID: await TencentImPlugin.invite(
            data: "邀请你进行视频通话3", invitee: _friendId),
        data: "123"),
    "accept": () async => TencentImPlugin.accept(
        inviteID: await TencentImPlugin.invite(
            data: "邀请你进行视频通话4", invitee: _friendId),
        data: "123"),
    "reject": () async => TencentImPlugin.reject(
        inviteID: await TencentImPlugin.invite(
            data: "邀请你进行视频通话5", invitee: _friendId),
        data: "123"),
    // "getSignalingInfo": () async => TencentImPlugin.getSignalingInfo(inviteID: await TencentImPlugin.invite(data: "邀请你进行视频通话", invitee: _friendId), data: "123"),
    "addInvitedSignaling": () async => TencentImPlugin.addInvitedSignaling(
          info: SignalingInfoEntity(
            inviter: _friendId,
            data: "test",
            actionType: SignalingActionTypeEnum.Invite,
            inviteeList: ["dev"],
          ),
        ),
    "sendMessage": () async => TencentImPlugin.sendMessage(
        receiver: _friendId, node: TextMessageNode(content: "1433223")),
    // "revokeMessage": () async => TencentImPlugin.revokeMessage(receiver: "dev", node: TextMessageNode(content: "1433223")),
    "getC2CHistoryMessageList": () async =>
        TencentImPlugin.getC2CHistoryMessageList(userID: _friendId, count: 100),
    "getGroupHistoryMessageList": () async =>
        TencentImPlugin.getGroupHistoryMessageList(
            groupID: _groupId, count: 100),
    "markC2CMessageAsRead": () async =>
        TencentImPlugin.markC2CMessageAsRead(userID: _friendId),
    "markGroupMessageAsRead": () async =>
        TencentImPlugin.markGroupMessageAsRead(groupID: _groupId),
    // "deleteMessageFromLocalStorage": () async => TencentImPlugin.deleteMessageFromLocalStorage(groupID: _groupId),
    // "deleteMessages": () async => TencentImPlugin.deleteMessages(groupID: _groupId),
    "insertGroupMessageToLocalStorage": () async =>
        TencentImPlugin.insertGroupMessageToLocalStorage(
          node: TextMessageNode(content: "1433223"),
          groupID: _groupId,
          sender: _friendId,
        ),
    // "createGroup": () async => TencentImPlugin.createGroup(
    //       info: GroupInfoEntity(
    //         groupType: GroupTypeEnum.Public,
    //         groupName: "测试群聊",
    //         notification: "这是群公告",
    //         introduction: "这是群简介",
    //       ),
    //     ),
    // "joinGroup": () async => TencentImPlugin.joinGroup(message: "申请入群", groupID: _groupId),
    // "quitGroup": () async => TencentImPlugin.quitGroup(groupID: _groupId),
    // "dismissGroup": () async => TencentImPlugin.dismissGroup(groupID: _groupId),
    "getJoinedGroupList": () async => TencentImPlugin.getJoinedGroupList(),
    "getGroupsInfo": () async =>
        TencentImPlugin.getGroupsInfo(groupIDList: [_groupId]),
    "setGroupInfo": () async => TencentImPlugin.setGroupInfo(
          info: GroupInfoEntity(
            groupID: _groupId,
            groupName: "${DateTime.now()}",
          ),
        ),
    "setReceiveMessageOpt": () async => TencentImPlugin.setReceiveMessageOpt(
          groupID: _groupId,
          opt: GroupReceiveMessageOptEnum.ReceiveAndNotify,
        ),
    "initGroupAttributes": () async => TencentImPlugin.initGroupAttributes(
          groupID: _avGroupId,
          attributes: {
            "a": "1",
            "b": "2",
          },
        ),
    "setGroupAttributes": () async => TencentImPlugin.setGroupAttributes(
          groupID: _avGroupId,
          attributes: {
            "c": "3",
            "d": "4",
          },
        ),
    "deleteGroupAttributes": () async =>
        TencentImPlugin.deleteGroupAttributes(groupID: _avGroupId, keys: ["b"]),
    "getGroupAttributes": () async =>
        TencentImPlugin.getGroupAttributes(groupID: _avGroupId),
    "getGroupMemberList": () async =>
        TencentImPlugin.getGroupMemberList(groupID: _groupId),
    "getGroupMembersInfo": () async => TencentImPlugin.getGroupMembersInfo(
        groupID: _groupId, memberList: [_friendId]),
    "setGroupMemberInfo": () async => TencentImPlugin.setGroupMemberInfo(
          groupID: _groupId,
          info: GroupMemberEntity(
            userID: _friendId,
            nameCard: "测试群名片",
          ),
        ),
    "muteGroupMember": () async => TencentImPlugin.muteGroupMember(
          groupID: _groupId,
          seconds: 60,
          userID: _friendId,
        ),
    // "inviteUserToGroup": () async => TencentImPlugin.inviteUserToGroup(
    //       groupID: _groupId,
    //       userList: [_friendId],
    //     ),
    // "kickGroupMember": () async => TencentImPlugin.kickGroupMember(
    //       groupID: _groupId,
    //       memberList: [_friendId],
    //     ),
    "setGroupMemberRole": () async => TencentImPlugin.setGroupMemberRole(
          groupID: _groupId,
          userID: _friendId,
          role: GroupMemberRoleEnum.Admin,
        ),
    // "transferGroupOwner": () async => TencentImPlugin.transferGroupOwner(
    //       groupID: _groupId,
    //       userID: _friendId,
    //     ),
    // "getGroupApplicationList": () async => TencentImPlugin.getGroupApplicationList(),
    // "acceptGroupApplication": () async => TencentImPlugin.acceptGroupApplication(),
    // "refuseGroupApplication": () async => TencentImPlugin.refuseGroupApplication(),
    "setGroupApplicationRead": () async =>
        TencentImPlugin.setGroupApplicationRead(),
    "getConversationList": () async => TencentImPlugin.getConversationList(),
    "getConversation": () async => TencentImPlugin.getConversation(
        conversationID: (await TencentImPlugin.getConversationList())
            .conversationList[0]
            .conversationID),
    "deleteConversation": () async => TencentImPlugin.deleteConversation(
        conversationID: (await TencentImPlugin.getConversationList())
            .conversationList[0]
            .conversationID),
    "setConversationDraft": () async => TencentImPlugin.setConversationDraft(
          conversationID: (await TencentImPlugin.getConversationList())
              .conversationList[0]
              .conversationID,
          draftText: "测试会话草稿",
        ),
    "getUsersInfo": () async =>
        TencentImPlugin.getUsersInfo(userIDList: [_friendId]),
    "setSelfInfo": () async => TencentImPlugin.setSelfInfo(
        info: UserEntity(nickName: "${DateTime.now()}")),
    "addToBlackList": () async =>
        TencentImPlugin.addToBlackList(userIDList: [_friendId]),
    "getBlackList": () async => TencentImPlugin.getBlackList(),
    "deleteFromBlackList": () async =>
        TencentImPlugin.deleteFromBlackList(userIDList: [_friendId]),
    "setOfflinePushConfig": () async => TencentImPlugin.setOfflinePushConfig(
        bussid: 10301, token: "请输入您的Token"),
    "setUnreadBadge": () async => TencentImPlugin.setUnreadBadge(number: 10),
    "getFriendList": () async => TencentImPlugin.getFriendList(),
    "getFriendsInfo": () async =>
        TencentImPlugin.getFriendsInfo(userIDList: [_friendId]),
    "setFriendInfo": () async => TencentImPlugin.setFriendInfo(
          info: FriendInfoEntity(
            userID: _friendId,
            friendRemark: "这是测试备注",
          ),
        ),
    "addFriend": () async => TencentImPlugin.addFriend(
          info: FriendAddApplicationEntity(
            userID: _friendId,
            friendRemark: "这是测试备注",
            addWording: "申请加为好友",
            addSource: "手动查找",
            addType: FriendTypeEnum.Both,
          ),
        ),
    "deleteFromFriendList": () async => TencentImPlugin.deleteFromFriendList(
        deleteType: FriendTypeEnum.Both, userIDList: [_friendId]),
    "checkFriend": () async => TencentImPlugin.checkFriend(
        userID: _friendId, checkType: FriendTypeEnum.Both),
    "getFriendApplicationList": () async =>
        TencentImPlugin.getFriendApplicationList(),
    // "acceptFriendApplication": () async => TencentImPlugin.acceptFriendApplication(),
    // "refuseFriendApplication": () async => TencentImPlugin.refuseFriendApplication(),
    // "deleteFriendApplication": () async => TencentImPlugin.deleteFriendApplication(),
    "setFriendApplicationRead": () async =>
        TencentImPlugin.setFriendApplicationRead(),
    "createFriendGroup": () async => TencentImPlugin.createFriendGroup(
        userIDList: [_friendId], groupName: "测试分组"),
    "getFriendGroups": () async =>
        TencentImPlugin.getFriendGroups(groupNameList: ["测试分组"]),
    "renameFriendGroup": () async =>
        TencentImPlugin.renameFriendGroup(oldName: "测试分组", newName: "test"),
    "addFriendsToFriendGroup": () async =>
        TencentImPlugin.addFriendsToFriendGroup(
            groupName: "test", userIDList: [_friendId]),
    "deleteFriendsFromFriendGroup": () async =>
        TencentImPlugin.deleteFriendsFromFriendGroup(
            groupName: "test", userIDList: [_friendId]),
    "deleteFriendGroup": () async =>
        TencentImPlugin.deleteFriendGroup(groupNameList: ["test"]),
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

  /// 回调描述
  List<String> _callResult = [];

  @override
  void initState() {
    super.initState();
    TencentImPlugin.addListener(_listener);
    TencentImPlugin.login(
      userID: "dev",
      userSig:
          "eJwtzEELgjAYxvHvsnPIu7U5EzoEQRDWITWqW7KVr8MaS8Yi*u6Zenx*D-w-pMjyyGtHUsIiILNho9KPDm84sNJ*4pcyV2tRkZRyALbgc8rHRweLTvcuhGAAMGqH7d9iEAKSWMipgve*ulZS1vKoT83uXO6rkAWzaoqtgVAdNpecu9Y-38aXtE6W5PsDr9ExPw__",
    );
  }

  @override
  void dispose() {
    super.dispose();
    TencentImPlugin.removeListener(_listener);
    TencentImPlugin.logout();
  }

  /// 监听器对象
  _listener(type, params) {
    _callResult
        .add("${_getDateTime()}-[${EnumUtil.getEnumName(type)}]:$params");
    if (this.mounted) {
      this.setState(() {});
    }
  }

  /// 获得时间字符串
  _getDateTime() {
    DateTime dateTime = DateTime.now();
    return "${dateTime.hour <= 9 ? "0${dateTime.hour}" : dateTime.hour}:${dateTime.minute <= 9 ? "0${dateTime.minute}" : dateTime.minute}:${dateTime.second <= 9 ? "0${dateTime.second}" : dateTime.second}";
  }

  /// 开始测试
  startTest() async {
    this.setState(() => _start = true);

    for (var key in _interfaces.keys) {
      this.setState(() => _currentTestKey = key);
      try {
        var resultData = await _interfaces[key]();
        _result.add("${_getDateTime()}-[$key]:测试通过；结果:$resultData");
      } catch (err) {
        _failInterfaces.add("$key : $err");
        _result.add("${_getDateTime()}-[$key]:$err");
        _logger.e(err, "[测试结果出错] $key");
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
                  TextSpan(
                      text: "${_finishTestCount - _failInterfaces.length}",
                      style: TextStyle(color: Colors.green)),
                  TextSpan(text: "，未通过:"),
                  TextSpan(
                      text: "${_failInterfaces.length}",
                      style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            _start
                ? Text((_finishTestCount == _interfaces.length)
                    ? "测试完成"
                    : "正在测试:$_currentTestKey")
                : RaisedButton(
                    onPressed: startTest,
                    child: Text("开始测试"),
                  ),
            Divider(),
            Text("日志信息"),
            Expanded(
                child: ListView(
              children: _result
                  .map(
                    (e) => RichText(
                      text: TextSpan(
                        text: e,
                        style: TextStyle(
                            color:
                                e.contains("测试通过") ? Colors.green : Colors.red),
                      ),
                    ),
                  )
                  .toList(),
            )),
            Divider(),
            Text("回调信息"),
            Expanded(
                child: ListView(
              children: _callResult
                  .map(
                    (e) => Text(e),
                  )
                  .toList(),
            )),
          ],
        ),
      ),
    );
  }
}
