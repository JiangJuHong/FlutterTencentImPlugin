import 'dart:io';
import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/entity/conversation_entity.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/entity/user_entity.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/enums/tencent_im_listener_type_enum.dart';
import 'package:tencent_im_plugin/message_node/text_message_node.dart';
import 'package:tencent_im_plugin/message_node/image_message_node.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';
import 'package:tencent_im_plugin/enums/message_elem_type_enum.dart';
import 'package:tencent_im_plugin/enums/image_type_enum.dart';
import 'package:image_picker/image_picker.dart';

/// 聊天页面
class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  /// 文本组件控制器
  TextEditingController _textEditingController = TextEditingController();

  /// 会话实体
  ConversationEntity _conversation;

  /// 消息列表
  List<MessageEntity> _messages = [];

  /// 用户信息
  UserEntity _selfUser;

  @override
  void initState() {
    super.initState();
    TencentImPlugin.addListener(_imListener);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _conversation = ModalRoute.of(context).settings.arguments;
      this.setState(() {});
      _loadUserInfo();
      _onLoadMessages();
      _textEditingController.text = _conversation.draftText;
    });
  }

  @override
  void dispose() {
    super.dispose();
    TencentImPlugin.removeListener(_imListener);
    String text = _textEditingController.text.trim();
    TencentImPlugin.setConversationDraft(
        conversationID: _conversation.conversationID,
        draftText: text.trim() != '' ? text : null);
  }

  /// IM监听器
  _imListener(type, params) {
    if (type == TencentImListenerTypeEnum.NewMessage) {
      this.setState(() {
        this._messages.insert(0, params);
      });
    }
  }

  /// 加载当前登录用户信息
  _loadUserInfo() async {
    this._selfUser = (await TencentImPlugin.getUsersInfo(
        userIDList: [await TencentImPlugin.getLoginUser()]))[0];
    this.setState(() {});
  }

  /// 加载消息
  _onLoadMessages() async {
    if (_conversation == null) {
      return;
    }
    List<MessageEntity> messages = await (_conversation.groupID != null
        ? TencentImPlugin.getGroupHistoryMessageList(
            groupID: _conversation.groupID, count: 100)
        : TencentImPlugin.getC2CHistoryMessageList(
            userID: _conversation.userID, count: 100));
    this.setState(() {
      this._messages = messages;
    });
  }

  /// 发送按钮点击事件
  _onSend() async {
    String text = _textEditingController.text;
    if (text.trim() == '') {
      return;
    }
    this._sendMessage(TextMessageNode(content: text));
    _textEditingController.text = "";
  }

  /// 图片选择按钮
  _onImageSelect() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    this._sendMessage(ImageMessageNode(path: pickedFile.path));
  }

  /// 根据消息获得组件
  _getMessageComponent(MessageEntity message) {
    // 文本消息
    if (message.elemType == MessageElemTypeEnum.Text) {
      return Text((message.node as TextMessageNode).content);
    }

    // 图片消息
    if (message.elemType == MessageElemTypeEnum.Image) {
      ImageMessageNode node = message.node;

      if ((node.path == null || node.path == '') && node.imageData != null) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: 100,
            maxWidth: 100,
          ),
          child: Image.network(node.imageData[ImageTypeEnum.Thumb]?.url),
        );
      }
      return Container(
        constraints: BoxConstraints(
          maxHeight: 100,
          maxWidth: 100,
        ),
        child: Image.file(File(node.path)),
      );
    }

    return Text("暂不支持的数据格式");
  }

  /// 发送消息
  _sendMessage(MessageNode node) {
    this._messages.insert(
          0,
          MessageEntity(
            node: node,
            faceUrl: _selfUser.faceUrl,
            elemType: node.nodeType,
          ),
        );

    TencentImPlugin.sendMessage(
      node: node,
      receiver: _conversation.userID,
      groupID: _conversation.groupID,
    );

    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(_conversation?.showName ?? "加载中..."),
        centerTitle: true,
        actions: [
          _conversation == null
              ? null
              : IconButton(
                  icon: Icon(_conversation.groupID != null
                      ? Icons.supervisor_account
                      : Icons.settings),
                  onPressed: () => {},
                ),
          Container(width: 8),
        ]..removeWhere((element) => element == null),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Flexible(
                  child: ListView(
                    reverse: true,
                    shrinkWrap: true,
                    children: _messages
                        .map(
                          (item) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: item.self
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Offstage(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage:
                                              item.faceUrl == null ||
                                                      item.faceUrl == ''
                                                  ? null
                                                  : NetworkImage(item.faceUrl),
                                        ),
                                        Container(width: 10),
                                      ],
                                    ),
                                    offstage: item.self,
                                  ),
                                  _getMessageComponent(item),
                                  Offstage(
                                    child: Row(
                                      children: [
                                        Container(width: 10),
                                        CircleAvatar(
                                          backgroundImage:
                                              item.faceUrl == null ||
                                                      item.faceUrl == ''
                                                  ? null
                                                  : NetworkImage(item.faceUrl),
                                        ),
                                      ],
                                    ),
                                    offstage: !item.self,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _onImageSelect,
                    child: Icon(
                      Icons.image_outlined,
                      size: 30,
                    ),
                  ),
                  Container(width: 8),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Icon(
                  //     Icons.mic,
                  //     size: 30,
                  //   ),
                  // ),
                  // Container(width: 8),
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 40,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color(0xFFEEEEEE),
                      ),
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            left: 15,
                            top: -8,
                            bottom: 0,
                            right: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(width: 8),
                  RaisedButton(
                    onPressed: _onSend,
                    child: Text("发送"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
