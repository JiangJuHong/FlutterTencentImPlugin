import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/entity/user_info_entity.dart';
import 'package:tencent_im_plugin/entity/group_info_entity.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/entity/node_entity.dart';
import 'package:tencent_im_plugin/entity/node_image_entity.dart';
import 'package:tencent_im_plugin/entity/node_text_entity.dart';

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
  /// 刷新加载器
  GlobalKey<RefreshIndicatorState> refreshIndicator = GlobalKey();

  /// 滚动控制器
  ScrollController scrollController = ScrollController();

  TextEditingController controller = TextEditingController();

  // 用户信息对象
  UserInfoEntity userInfo;

  // 群信息对象
  GroupInfoEntity groupInfoEntity;

  // 当前消息列表
  List<MessageEntity> messageData = [];

  @override
  initState() {
    super.initState();
    // 获取对话信息
    if (widget.type == SessionType.Group) {
      TencentImPlugin.getGroupInfo(id: widget.id).then((data) {
        this.setState(() {
          groupInfoEntity = data;
        });
      });
    } else if (widget.type == SessionType.C2C) {
      TencentImPlugin.getUserInfo(id: widget.id).then((data) {
        this.setState(() {
          userInfo = data;
        });
      });
    }

    // 获得消息列表
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // 读取缓存
      TencentImPlugin.getLocalMessages(
        sessionId: widget.id,
        sessionType: widget.type,
        number: 30,
      ).then((res) {
        this.setState(() => messageData = res);
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });

      refreshIndicator.currentState.show();
    });
  }

  /// 发送事件
  onSend() {}

  /// 获取消息列表事件
  Future<void> onRefresh() {
    return TencentImPlugin.getMessages(
      sessionId: widget.id,
      sessionType: widget.type,
      number: messageData.length + 30,
    ).then((res) {
      this.setState(() => messageData = res);
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userInfo != null
              ? userInfo.nickName
              : (groupInfoEntity != null
                  ? "${groupInfoEntity.groupName}(${groupInfoEntity.memberNum})"
                  : ""),
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        child: Column(
          children: <Widget>[
            Expanded(
              child: RefreshIndicator(
                onRefresh: onRefresh,
                key: refreshIndicator,
                child: ListView(
                  controller: scrollController,
                  children: List.generate(messageData.length, (index)=>MessageItem(message: messageData[messageData.length - index - 1])),
                ),
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
      ),
    );
  }
}

/// 消息条目
class MessageItem extends StatelessWidget {
  final MessageEntity message;

  const MessageItem({Key key, this.message}) : super(key: key);

  /// 获得消息描述
  onGetMessageDesc(MessageEntity message) {
    if (message == null ||
        message.elemList == null ||
        message.elemList.length == 0) {
      return Text("");
    }

    NodeEntity node = message.elemList[0];
    if (node is NodeTextEntity) {
      return Text(node.text);
    } else if (node is NodeImageEntity) {
      return Image.network(node.imageData[ImageType.Original].url);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          !message.self
              ? Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: message.userInfo.faceUrl == null
                          ? null
                          : Image.network(
                              message.userInfo.faceUrl,
                              fit: BoxFit.cover,
                            ).image,
                    ),
                    Container(width: 5),
                  ],
                )
              : Container(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: message.self
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: <Widget>[
                Text(message.userInfo.nickName ?? ""),
                Container(height: 5),
                Container(
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 7,
                    right: 7,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  child: this.onGetMessageDesc(message),
                ),
              ],
            ),
          ),
          message.self
              ? Row(
                  children: <Widget>[
                    Container(width: 5),
                    CircleAvatar(
                      backgroundImage: message.userInfo.faceUrl == null
                          ? null
                          : Image.network(
                              message.userInfo.faceUrl,
                              fit: BoxFit.cover,
                            ).image,
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
