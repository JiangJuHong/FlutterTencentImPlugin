import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:correct_camera_utils/camera_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tencent_im_plugin/enums/message_status_enum.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/entity/user_info_entity.dart';
import 'package:tencent_im_plugin/entity/group_info_entity.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/entity/node_entity.dart';
import 'package:tencent_im_plugin/entity/node_image_entity.dart';
import 'package:tencent_im_plugin/message_node/text_message_node.dart';
import 'package:tencent_im_plugin/message_node/sound_message_node.dart';
import 'package:tencent_im_plugin/message_node/video_message_node.dart';
import 'package:tencent_im_plugin/message_node/image_message_node.dart';
import 'package:tencent_im_plugin/message_node/location_message_node.dart';
import 'package:video_player/video_player.dart';

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
        addData(params);
      });
      // 设置已读
      TencentImPlugin.setRead(sessionId: widget.id, sessionType: widget.type);
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
      Widget widget = getComponent(item.elemList);
      if (widget != null) {
        dataEntity.add(
          new DataEntity(
            userInfo: item.userInfo,
            self: item.self,
            widget: widget,
            message: item,
          ),
        );
      }
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
    if (node == null) {
      return null;
    }
    if (node.type == NodeType.Text) {
      return MessageText(text: node.text);
    } else if (node.type == NodeType.Image) {
      return MessageImage(url: node.imageData[ImageType.Original].url);
    } else if (node.type == NodeType.Sound) {
      return MessageVoice(path: node.path, duration: node.duration);
    } else if (node.type == NodeType.Video) {
      return InkWell(
        onTap: () {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: new Text('视频播放功能暂未实现')));
        },
        child: MessageVideo(
          path: node.videoPath,
          duration: node.videoInfo.duaration,
          snapshotPath: node.snapshotPath,
        ),
      );
    } else if (node.type == NodeType.Location) {
      return MessageLocation(
        desc: node.desc,
        latitude: node.latitude,
        longitude: node.longitude,
      );
    }
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
    var image = await CameraUtils.pickImage;
    if (image != null) {
      this.sendMessage(
        MessageImage(
          path: image,
        ),
        ImageMessageNode(
          path: image,
        ),
      );
    }
  }

  /// 选择视频
  onSelectVideo() async {
    // 选择视频并截取后缀
    final video = await CameraUtils.pickVideo;
    String type = "";
    List<String> suffix = video.split(".");
    if (suffix.length >= 2) {
      type = suffix[suffix.length - 1];
    }

    // 获得控制器并获得视频时长
    VideoPlayerController playerController =
        VideoPlayerController.file(File(video));
    await playerController.initialize();
    int duration = playerController.value.duration.inSeconds;

    // 获得视频缩略图
    String thumb = await CameraUtils.getThumbnail(video);

    this.sendMessage(
      VideoMessageNode(
        path: video,
        duration: duration,
        type: type,
        snapshotPath: thumb,
        snapshotHeight: 0,
        snapshotWidth: 0,
      ),
      MessageVideo(
        path: video,
        snapshotPath: thumb,
        duration: duration,
      ),
    );
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
    // 发送视频消息
    TencentImPlugin.sendMessage(
      sessionId: widget.id,
      sessionType: widget.type,
      node: node,
    ).catchError((e){
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: new Text('消息发送失败:$e')));
    });

    int id = Random().nextInt(999999);
    // 封装数据对象
    DataEntity dataEntity = DataEntity(
      id: id.toString(),
      userInfo: loginUserInfo,
      widget: wd,
      self: true,
    );

    this.setState(() {
      data.add(dataEntity);
    });
  }

  /// 消息长按事件
  onMessageLongPress(index, DataEntity item, BuildContext context) {
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
              sessionId: item.message.sessionId,
              sessionType: item.message.sessionType,
              rand: item.message.rand,
              seq: item.message.seq,
              timestamp: item.message.timestamp,
            ).then((_) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: new Text('消息撤回成功!')));
              this.setState(() =>
                  data[index].message.status = MessageStatusEum.HasRevoked);
            }).catchError((e) {
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: new Text('消息撤回失败:$e')));
            });
            break;
          case 1:
            TencentImPlugin.removeMessage(
              sessionId: item.message.sessionId,
              sessionType: item.message.sessionType,
              rand: item.message.rand,
              seq: item.message.seq,
              timestamp: item.message.timestamp,
              self: item.message.self,
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
              sessionId: item.message.sessionId,
              sessionType: item.message.sessionType,
              rand: item.message.rand,
              seq: item.message.seq,
              timestamp: item.message.timestamp,
              self: item.message.self,
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
              sessionId: item.message.sessionId,
              sessionType: item.message.sessionType,
              rand: item.message.rand,
              seq: item.message.seq,
              timestamp: item.message.timestamp,
              self: item.message.self,
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
            Scaffold.of(context).showSnackBar(SnackBar(
                content: new Text('获得的自定义整型为:${item.message.customInt}')));
            break;
          case 5:
            Scaffold.of(context).showSnackBar(SnackBar(
                content: new Text('获得的自定义字符串为:${item.message.customStr}')));
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
                          onLongPress: () =>
                              onMessageLongPress(index, data[index], context),
                          child: MessageItem(data: data[index]),
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
  /// id，可自定义
  final String id;

  final MessageEntity message;

  /// 用户信息
  final UserInfoEntity userInfo;

  /// 是否是自己
  final bool self;

  /// 显示组件
  final Widget widget;

  DataEntity({
    this.id,
    this.userInfo,
    this.self,
    this.widget,
    this.message,
  });
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
                  child: data.message != null &&
                          data.message.status == MessageStatusEum.HasRevoked
                      ? Text("[该消息已被撤回]")
                      : data.widget,
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
          : Image.network(
              url,
              fit: BoxFit.cover,
            ),
    );
  }
}

/// 消息语音
class MessageVoice extends StatelessWidget {
  // 路径
  final String path;

  // 时间
  final int duration;

  /// 语音插件
  final FlutterSound flutterSound = new FlutterSound();

  MessageVoice({Key key, this.path, this.duration}) : super(key: key);

  // 播放语音
  onPlayerOrStop() {
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
class MessageVideo extends StatelessWidget {
  // 封面截图
  final String snapshotPath;

  // 路径
  final String path;

  // 时间
  final int duration;

  MessageVideo({Key key, this.path, this.duration, this.snapshotPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => 0,
      child: Container(
        height: 100,
        width: 100,
        child: Stack(
          children: <Widget>[
            MessageImage(path: snapshotPath),
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
                "$duration″",
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
