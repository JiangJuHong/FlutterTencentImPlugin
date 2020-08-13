import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tencent_im_plugin/enums/message_status_enum.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/entity/user_info_entity.dart';
import 'package:tencent_im_plugin/entity/group_info_entity.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/enums/message_node_type.dart';
import 'package:tencent_im_plugin/enums/image_type.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';
import 'package:tencent_im_plugin/message_node/text_message_node.dart';
import 'package:tencent_im_plugin/message_node/sound_message_node.dart';
import 'package:tencent_im_plugin/message_node/video_message_node.dart';
import 'package:tencent_im_plugin/message_node/image_message_node.dart';
import 'package:tencent_im_plugin/message_node/location_message_node.dart';
import 'package:tencent_im_plugin/message_node/entity/video_info_entity.dart';
import 'package:tencent_im_plugin/message_node/entity/video_snapshot_info_entity.dart';
import 'package:tencent_im_plugin_example/listener/ListenerFactory.dart';
import 'package:tencent_im_plugin_example/page/video_player_page.dart';
import 'package:tencent_im_plugin_example/utils/dialog_util.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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
  /// 语音插件
  final FlutterSound flutterSound = new FlutterSound();

  /// 语音最长秒速
  final int voiceMaxSecond = 60;

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

  /// 代表是否讲话中
  bool speech = false;

  /// 开始的位置
  double start = 0.0;

  /// 偏移量
  double offset = 0.0;

  /// 是否移除语音区域
  bool removeVoice = false;

  /// 文本内容
  String textShow = "按住说话";

  /// 是否显示语音界面
  bool voiceWindow = false;

  /// 录制的语音路径
  String voicePath;

  /// 当前语音秒速
  int voiceCurrentSecond = 0;

  /// 计数器
  Timer _timer;

  /// 用作显示提示框
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  initState() {
    super.initState();

    init();

    // 获得当前登录用户
    TencentImPlugin.getSelfProfile().then((data) {
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
        resetData(res);
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
    // 取消计数器
    stopTimer();
  }

  /// 初始化
  init() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([
      PermissionGroup.storage,
      PermissionGroup.storage,
      PermissionGroup.microphone
    ]);
  }

  /// 监听器
  listener(type, params) {
    // 新消息时更新会话列表最近的聊天记录
    if (type == ListenerTypeEnum.NewMessages) {
      // 更新消息列表
      this.setState(() {
        data.add(DataEntity(data: params));
      });
      // 设置已读
      TencentImPlugin.setRead(sessionId: widget.id, sessionType: widget.type);
    }

    // 消息上传通知
    if (type == ListenerTypeEnum.UploadProgress) {
      Map<String, dynamic> obj = jsonDecode(params);

      // 获得进度和消息实体
      int progress = obj["progress"];
      MessageEntity message = MessageEntity.fromJson(obj["message"]);

      // 更新数据
      this.updateData(DataEntity(
        data: message,
        progress: progress,
      ));
    }
  }

  /// 发送事件
  onSend() async {
    if (controller.text == null || controller.text.trim() == "") {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('不能发送空值!'), duration: Duration(milliseconds: 2000)));
      return;
    }

    this.sendMessage(
      TextMessageNode(
        content: controller.text,
      ),
      MessageText(text: controller.text),
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
      resetData(res);
      // 设置已读
      TencentImPlugin.setRead(sessionId: widget.id, sessionType: widget.type);
    });
  }

  /// 更新显示的数据
  resetData(List<MessageEntity> messageEntity) {
    this.data = [];
    for (var item in messageEntity) {
      this.updateData(DataEntity(data: item));
    }

    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  /// 更新单个数据
  updateData(DataEntity dataEntity) {
    bool exist = false;
    for (var index = 0; index < data.length; index++) {
      DataEntity item = data[index];
      if (item.data == dataEntity.data) {
        this.data[index] = dataEntity;
        exist = true;
        break;
      }
    }

    if (!exist) {
      this.data.add(dataEntity);
    }

    this.setState(() {});
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  /// 获得组件
  getComponent(MessageEntity message) {
    List<MessageNode> elems = message.elemList;
    if (elems == null || elems.length == 0) {
      return Text("");
    }

    // 只取第一个
    var node = elems[0];
    if (node == null) {
      return null;
    }

    switch (node.nodeType) {
      case MessageNodeType.Text:
        TextMessageNode value = node;
        return MessageText(text: value.content);
      case MessageNodeType.Image:
        ImageMessageNode value = node;
        return MessageImage(
            url: value.imageData[ImageType.Original]?.url, path: value.path);
      case MessageNodeType.Sound:
        SoundMessageNode value = node;
        return MessageVoice(
          data: message,
          soundNode: value,
        );
      case MessageNodeType.Custom:
        return MessageText(text: "[自定义节点，未指定解析规则]");
        break;
      case MessageNodeType.Video:
        VideoMessageNode value = node;
        return MessageVideo(
          data: message,
          videoNode: value,
        );
      case MessageNodeType.Location:
        LocationMessageNode value = node;
        return MessageLocation(
          desc: value.desc,
          latitude: value.latitude,
          longitude: value.longitude,
        );
      case MessageNodeType.GroupTips:
        return MessageText(text: "[群提示节点，未指定解析规则]");
      case MessageNodeType.Other:
      case MessageNodeType.SnsTips:
        break;
    }
    return MessageText(text: "[不支持的消息节点]");
  }

  /// 显示界面
  showVoiceView() {
    setState(() {
      textShow = "松开手指,取消发送";
      speech = true;
    });
    flutterSound.startRecorder().then((res) {
      this.setState(() => voicePath = res);
    });

    // 开启计时器
    startTimer();
  }

  /// 隐藏界面
  hideVoiceView() {
    stopVoice();
  }

  /// 移动界面
  moveVoiceView() {
    setState(() {
      removeVoice = start - offset > 150 ? true : false;
      if (removeVoice) {
        textShow = "松开手指,取消发送";
      } else {
        textShow = "手指上滑,取消发送";
      }
    });
  }

  /// 停止语音录制
  stopVoice() {
    // 如果已经停止，则不重复操作
    if (!speech) {
      return;
    }

    // 停止计时器
    stopTimer();

    // 停止录制
    if (flutterSound.isRecording) {
      flutterSound.stopRecorder().then((res) {
        if (removeVoice) {
          File file = File(voicePath);
          file.exists().then((exist) {
            if (exist) {
              file.delete();
            }
          });
        } else {
          // 发送语音
          sendVoice(voicePath, voiceCurrentSecond);
        }
        // 重置
        this.setState(() {
          removeVoice = false;
          speech = false;
          textShow = "按住说话";
          voiceCurrentSecond = 0;
        });
      });
    }
  }

  /// 开启计时器
  startTimer() {
    // 开启倒计时
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      this.setState(() {
        voiceCurrentSecond = voiceCurrentSecond + 1;
      });
      // 停止计时器
      if (voiceCurrentSecond == voiceMaxSecond) {
        stopVoice();
      }
    });
  }

  /// 关闭计时器
  stopTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  /// 发送语音
  sendVoice(path, duration) {
    if (duration <= 1) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('时间太短!'), duration: Duration(milliseconds: 2000)));
      return;
    }

    this.sendMessage(
      SoundMessageNode(
        duration: voiceCurrentSecond,
        path: voicePath,
      ),
      MessageVoice(
        path: path,
        duration: duration,
      ),
    );
  }

  /// 选择图片
  onSelectImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      this.sendMessage(
        ImageMessageNode(
          path: image.path,
        ),
        MessageImage(
          path: image.path,
        ),
      );
    }
  }

  /// 选择视频
  onSelectVideo() async {
    // 选择视频并截取后缀
    final video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      String type = "";
      List<String> suffix = video.path.split(".");
      if (suffix.length >= 2) {
        type = suffix[suffix.length - 1];
      }

      DialogUtil.showLoading(context, "处理中");

      // 获得视频缩略图
      String thumb = await VideoThumbnail.thumbnailFile(
        video: video.path,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        quality: 25,
      );

      // 获得控制器并获得视频时长
      VideoPlayerController playerController =
          VideoPlayerController.file(File(video.path));
      await playerController.initialize();
      int duration = playerController.value.duration.inSeconds;

      DialogUtil.cancelLoading(context);

      // 发送视频
      this.sendMessage(
        VideoMessageNode(
          videoInfo: VideoInfo(
            path: video.path,
            duration: duration,
            type: type,
          ),
          videoSnapshotInfo: VideoSnapshotInfo(
            path: thumb,
            height: 0,
            width: 0,
          ),
        ),
        MessageVideo(
          image: thumb,
          video: video.path,
          duration: duration,
        ),
      );
    }
  }

  /// 选择位置
  onSelectLocation() {
    String desc = "北京";
    double longitude = 116.397128;
    double latitude = 39.916527;

    this.sendMessage(
      LocationMessageNode(
        desc: desc,
        longitude: longitude,
        latitude: latitude,
      ),
      MessageLocation(
        desc: desc,
        longitude: longitude,
        latitude: latitude,
      ),
    );
  }

  /// 发送消息
  sendMessage(node, wd) {
    TencentImPlugin.sendMessage(
      sessionId: widget.id,
      sessionType: widget.type,
      node: node,
    ).then((res) {
      this.setState(() {
        this.updateData(DataEntity(data: res));
      });
    }).catchError((e) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: new Text('消息发送失败:$e')));
    });
  }

  /// 消息长按事件
  onMessageLongPress(index, MessageEntity item, BuildContext context) {
    final RenderBox renderBoxRed = context.findRenderObject();
    final positionRed = renderBoxRed.localToGlobal(Offset.zero);
    showMenu(
      items: <PopupMenuEntry>[
        item.self
            ? PopupMenuItem(
                value: 0,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.redo),
                    Text("撤回"),
                  ],
                ),
              )
            : null,
        PopupMenuItem(
          value: 1,
          child: Row(
            children: <Widget>[
              Icon(Icons.delete),
              Text("删除"),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: <Widget>[
              Icon(Icons.send),
              Text("设置自定义随机值(Int)"),
            ],
          ),
        ),
        PopupMenuItem(
          value: 3,
          child: Row(
            children: <Widget>[
              Icon(Icons.send),
              Text("设置自定义随机值(String)"),
            ],
          ),
        ),
        PopupMenuItem(
          value: 4,
          child: Row(
            children: <Widget>[
              Icon(Icons.send),
              Text("获得自定义随机值(Int)"),
            ],
          ),
        ),
        PopupMenuItem(
          value: 5,
          child: Row(
            children: <Widget>[
              Icon(Icons.send),
              Text("获得自定义随机值(String)"),
            ],
          ),
        ),
      ],
      context: context,
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width - 70,
        positionRed.dy - 10,
        0,
        0,
      ),
    ).then((res) {
      if (res != null) {
        switch (res) {
          case 0:
            TencentImPlugin.revokeMessage(
              message: item,
            ).then((_) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: new Text('消息撤回成功!')));
              data[index].data.status = MessageStatusEnum.HasRevoked;
              if (this.mounted) {
                this.setState(() {});
              }
            }).catchError((e) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: new Text('消息撤回失败:$e')));
            });
            break;
          case 1:
            TencentImPlugin.removeMessage(
              message: item,
            ).then((result) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: new Text('消息删除:$result')));
              this.setState(() => data.removeAt(index));
            }).catchError((e) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: new Text('消息删除失败:$e')));
            });
            break;
          case 2:
            int value = new Random(0).nextInt(9999999);
            TencentImPlugin.setMessageCustomInt(
              message: item,
              value: value,
            ).then((result) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: new Text('设置自定义整型成功:$value，为了确保成功，请返回界面后重试')));
            }).catchError((e) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: new Text('设置自定义整型失败:$e')));
            });
            break;
          case 3:
            String value =
                "string=${new Random(0).nextInt(9999999).toString()}";
            TencentImPlugin.setMessageCustomStr(
              message: item,
              value: value,
            ).then((result) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: new Text('设置自定义字符串成功:$value，为了确保成功，请返回界面后重试')));
            }).catchError((e) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: new Text('设置自定义字符串失败:$e')));
            });
            break;
          case 4:
            Scaffold.of(context).showSnackBar(
                SnackBar(content: new Text('获得的自定义整型为:${item.customInt}')));
            break;
          case 5:
            Scaffold.of(context).showSnackBar(
                SnackBar(content: new Text('获得的自定义字符串为:${item.customStr}')));
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  children: List.generate(
                    data.length,
                    (index) => LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return GestureDetector(
                          onLongPress: () => onMessageLongPress(
                              index, data[index].data, context),
                          child: MessageItem(
                            data: data[index],
                            child: getComponent(data[index].data),
                          ),
                        );
                      },
                    ),
                  ),
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
                  InkWell(
                    onTap: () =>
                        this.setState(() => voiceWindow = !voiceWindow),
                    child: Container(
                      child: Icon(
                        Icons.mic,
                        color: voiceWindow ? Colors.blueAccent : Colors.black,
                      ),
                      padding: EdgeInsets.only(left: 5, right: 5),
                    ),
                  ),
                  InkWell(
                    onTap: onSelectImage,
                    child: Container(
                      child: Icon(
                        Icons.image,
                      ),
                      padding: EdgeInsets.only(left: 5, right: 5),
                    ),
                  ),
                  InkWell(
                    onTap: onSelectVideo,
                    child: Container(
                      child: Icon(
                        Icons.videocam,
                      ),
                      padding: EdgeInsets.only(left: 5, right: 5),
                    ),
                  ),
                  InkWell(
                    onTap: onSelectLocation,
                    child: Container(
                      child: Icon(
                        Icons.location_on,
                      ),
                      padding: EdgeInsets.only(left: 5, right: 5),
                    ),
                  ),
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
            voiceWindow
                ? GestureDetector(
                    onVerticalDragStart: (details) {
                      start = details.globalPosition.dy;
                      showVoiceView();
                    },
                    onVerticalDragEnd: (details) {
                      hideVoiceView();
                    },
                    onVerticalDragUpdate: (details) {
                      offset = details.globalPosition.dy;
                      moveVoiceView();
                    },
                    child: Container(
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.grey[200],
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.red),
                                  value: voiceCurrentSecond / voiceMaxSecond,
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: speech
                                      ? (removeVoice ? Colors.red : Colors.blue)
                                      : Colors.grey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(150),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.keyboard_voice,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                    Container(height: 10),
                                    Text(
                                      textShow,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

/// 数据实体
class DataEntity {
  /// 消息实体
  final MessageEntity data;

  /// 进度
  final int progress;

  DataEntity({
    this.data,
    this.progress,
  });
}

/// 消息条目
class MessageItem extends StatelessWidget {
  /// 消息对象
  final DataEntity data;

  /// 子组件
  final Widget child;

  const MessageItem({
    Key key,
    this.data,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          !data.data.self
              ? Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: data.data.userInfo.faceUrl == null
                          ? null
                          : Image.network(
                              data.data.userInfo.faceUrl,
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
              crossAxisAlignment: data.data.self
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: <Widget>[
                Text(data.data.userInfo.nickName ?? ""),
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
                    borderRadius: BorderRadius.all(
                      Radius.circular(3),
                    ),
                  ),
                  child: data != null &&
                          data.data.status == MessageStatusEnum.HasRevoked
                      ? Text("[该消息已被撤回]")
                      : child,
                ),
                Container(),
                data.progress != null && data.progress < 100
                    ? Text("${data.progress}%")
                    : Container(),
              ],
            ),
          ),
          data.data.self
              ? Row(
                  children: <Widget>[
                    Container(width: 5),
                    CircleAvatar(
                      backgroundImage: data.data.userInfo.faceUrl == null
                          ? null
                          : Image.network(
                              data.data.userInfo.faceUrl,
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
  final String path;

  const MessageImage({Key key, this.url, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: path != null
          ? Image.file(
              File(path),
              fit: BoxFit.cover,
            )
          : url != null
              ? Image.network(
                  url,
                  fit: BoxFit.cover,
                )
              : Container(),
    );
  }
}

/// 消息语音
class MessageVoice extends StatefulWidget {
  /// 消息实体
  final MessageEntity data;

  /// 语音节点
  final SoundMessageNode soundNode;

  /// 路径
  final String path;

  /// 时间
  final int duration;

  const MessageVoice(
      {Key key, this.data, this.soundNode, this.path, this.duration})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => MessageVoiceState();
}

class MessageVoiceState extends State<MessageVoice> {
  /// 语音插件
  final FlutterSound flutterSound = new FlutterSound();

  /// 语音路径
  String path;

  /// 时间
  int duration;

  @override
  void initState() {
    super.initState();
    path = widget.path ?? widget.soundNode.path;
    duration = widget.duration ?? widget.soundNode.duration;

    // 添加腾讯云IM监听器，监听进度
    TencentImPlugin.addListener(tencentImListener);
  }

  @override
  void dispose() {
    super.dispose();
    TencentImPlugin.removeListener(tencentImListener);
  }

  /// 腾讯云IM监听器
  tencentImListener(type, params) {
    if (type == ListenerTypeEnum.DownloadProgress) {
      Map<String, dynamic> obj = jsonDecode(params);
      if (widget.data == MessageEntity.fromJson(obj["message"])) {
        ListenerFactory.progressDialogChangeNotifier.value =
            obj["currentSize"] / obj["totalSize"];
      }
    }
  }

  // 播放语音
  onPlayerOrStop() async {
    // 如果视频文件为空，就下载视频
    DialogUtil.showProgressLoading(context);
    this.path = await TencentImPlugin.downloadSound(
      message: widget.data,
      path: path,
    );
    DialogUtil.cancelLoading(context);
    if (this.mounted) {
      this.setState(() {});
    }

    if (flutterSound.isPlaying) {
      flutterSound.stopPlayer();
    } else {
      flutterSound.startPlayer(path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPlayerOrStop,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.subject),
          Text("$duration ″"),
        ],
      ),
    );
  }
}

/// 消息视频
class MessageVideo extends StatefulWidget {
  /// 消息实体
  final MessageEntity data;

  /// 视频节点
  final VideoMessageNode videoNode;

  /// 图片
  final String image;

  /// 视频
  final String video;

  /// 时长
  final int duration;

  const MessageVideo({
    Key key,
    this.data,
    this.videoNode,
    this.image,
    this.video,
    this.duration,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MessageVideoState();
}

class MessageVideoState extends State<MessageVideo> {
  /// 缩略图文件
  String snapshotImage;

  /// 视频文件
  String video;

  @override
  void initState() {
    super.initState();

    snapshotImage = widget.image ?? widget.videoNode.videoSnapshotInfo.path;
    video = widget.video ?? widget.videoNode.videoInfo.path;

    // 添加腾讯云IM监听器，监听进度
    TencentImPlugin.addListener(tencentImListener);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      TencentImPlugin.downloadVideoImage(
        message: widget.data,
        path: snapshotImage,
      ).then((res) {
        snapshotImage = res;
        if (this.mounted) {
          this.setState(() {});
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    TencentImPlugin.removeListener(tencentImListener);
  }

  /// 腾讯云IM监听器
  tencentImListener(type, params) {
    if (type == ListenerTypeEnum.DownloadProgress) {
      Map<String, dynamic> obj = jsonDecode(params);
      if (widget.data == MessageEntity.fromJson(obj["message"])) {
        ListenerFactory.progressDialogChangeNotifier.value =
            obj["currentSize"] / obj["totalSize"];
      }
    }
  }

  /// 视频点击事件
  onVideoClick() async {
    // 如果视频文件为空，就下载视频
    DialogUtil.showProgressLoading(context);
    this.video = await TencentImPlugin.downloadVideo(
      message: widget.data,
      path: video,
    );
    DialogUtil.cancelLoading(context);
    if (this.mounted) {
      this.setState(() {});
    }

    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new VideoPlayerPage(
          file: video,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onVideoClick,
      child: Container(
        height: 100,
        width: 100,
        child: Stack(
          children: <Widget>[
            MessageImage(path: snapshotImage),
            Align(
              alignment: new FractionalOffset(0.5, 0.5),
              child: Icon(
                Icons.play_circle_outline,
                color: Colors.white,
                size: 30,
              ),
            ),
            Positioned(
              right: 5,
              bottom: 5,
              child: Text(
                "${widget.duration ?? widget.videoNode.videoInfo.duration}″",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 消息位置
class MessageLocation extends StatelessWidget {
  /// 描述
  final String desc;

  /// 经度
  final double longitude;

  /// 纬度
  final double latitude;

  const MessageLocation({Key key, this.desc, this.longitude, this.latitude})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => 0,
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey,
        child: Column(
          children: <Widget>[
            Text(desc),
            Text("经度:$longitude"),
            Text("纬度:$latitude"),
          ],
        ),
      ),
    );
  }
}
