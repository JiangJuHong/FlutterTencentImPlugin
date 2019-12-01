import 'dart:async';
import 'dart:math';

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

  /// 用户信息对象
  UserInfoEntity userInfo;

  /// 获取当前登录用户的UserInfoEntity
  UserInfoEntity loginUserInfo;

  /// 群信息对象
  GroupInfoEntity groupInfoEntity;

  /// 当前消息列表
  List<DataEntity> data = [];

  @override
  initState() {
    super.initState();

    // 获得当前登录用户
    TencentImPlugin.getLoginUserInfo().then((data) {
      this.setState(() {
        loginUserInfo = data;
      });
    });

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
        resetDate(res);
      });

      refreshIndicator.currentState.show();
    });

    // 添加监听器
    TencentImPlugin.addListener(listener);
  }

  @override
  dispose() {
    super.dispose();
    TencentImPlugin.removeListener(listener);
  }

  /// 监听器
  listener(type, params) {
    // 新消息时更新会话列表最近的聊天记录
    if (type == ListenerTypeEnum.NewMessages) {
      // 更新消息列表
      this.setState(() {
        addData(params);
      });
      // 设置已读
      TencentImPlugin.setRead(sessionId: widget.id, sessionType: widget.type);
    }
  }

  /// 发送事件
  onSend() {
    if (controller.text == null || controller.text.trim() == "") {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('不能发送空值!'), duration: Duration(milliseconds: 2000)));
      return;
    }
    int id = Random().nextInt(999999);

    // 封装数据对象
    DataEntity dataEntity = DataEntity(
      id: id.toString(),
      userInfo: loginUserInfo,
      widget: MessageText(text: controller.text),
      self: true,
    );

    this.setState(() {
      data.add(dataEntity);
    });

    // 发送消息
    TencentImPlugin.sendTextMessage(
      sessionId: widget.id,
      sessionType: widget.type,
      content: controller.text,
    );
    controller.text = "";

    Timer(
        Duration(milliseconds: 200),
        () =>
            scrollController.jumpTo(scrollController.position.maxScrollExtent));
  }

  /// 获取消息列表事件
  Future<void> onRefresh() {
    return TencentImPlugin.getMessages(
      sessionId: widget.id,
      sessionType: widget.type,
      number: data.length + 30,
    ).then((res) {
      resetDate(res);
      // 设置已读
      TencentImPlugin.setRead(sessionId: widget.id, sessionType: widget.type);
    });
  }

  /// 更新显示的数据
  resetDate(List<MessageEntity> messageEntity) {
    this.data = [];
    addData(messageEntity);
  }

  /// 添加显示数据
  addData(List<MessageEntity> messageEntity) {
    List<DataEntity> dataEntity = this.data;
    for (var item in messageEntity) {
      dataEntity.add(new DataEntity(
        userInfo: item.userInfo,
        self: item.self,
        widget: getComponent(item.elemList),
      ));
    }
    this.setState(() {});
    Timer(
        Duration(milliseconds: 200),
        () =>
            scrollController.jumpTo(scrollController.position.maxScrollExtent));
  }

  /// 获得组件
  getComponent(List elems) {
    if (elems == null || elems.length == 0) {
      return Text("");
    }

    // 只取第一个
    var node = elems[0];
    if (node.type == NodeType.Text) {
      return MessageText(text: node.text);
    } else if (node.type == NodeType.Image) {
      return MessageImage(url: node.imageData[ImageType.Original].url);
    }
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
        color: Colors.grey[200],
        child: Column(
          children: <Widget>[
            Expanded(
              child: RefreshIndicator(
                onRefresh: onRefresh,
                key: refreshIndicator,
                child: ListView(
                  controller: scrollController,
                  children:
                      data.map((item) => MessageItem(data: item)).toList(),
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

/// 数据实体
class DataEntity {
  /// id，可自定义
  final String id;

  /// 用户信息
  final UserInfoEntity userInfo;

  /// 是否是自己
  final bool self;

  /// 显示组件
  final Widget widget;

  DataEntity({this.id, this.userInfo, this.self, this.widget});
}

/// 消息条目
class MessageItem extends StatelessWidget {
  final DataEntity data;

  const MessageItem({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          !data.self
              ? Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: data.userInfo.faceUrl == null
                          ? null
                          : Image.network(
                              data.userInfo.faceUrl,
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
              crossAxisAlignment:
                  data.self ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(data.userInfo.nickName ?? ""),
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
                  child: data.widget,
                ),
              ],
            ),
          ),
          data.self
              ? Row(
                  children: <Widget>[
                    Container(width: 5),
                    CircleAvatar(
                      backgroundImage: data.userInfo.faceUrl == null
                          ? null
                          : Image.network(
                              data.userInfo.faceUrl,
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

/// 消息文本
class MessageText extends StatelessWidget {
  final String text;

  const MessageText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}

/// 消息图片
class MessageImage extends StatelessWidget {
  final String url;

  const MessageImage({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(url);
  }
}
