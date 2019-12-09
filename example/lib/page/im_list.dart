import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/entity/node_entity.dart';
import 'package:tencent_im_plugin/entity/node_text_entity.dart';
import 'package:tencent_im_plugin/entity/node_sound_entity.dart';
import 'package:tencent_im_plugin/entity/node_image_entity.dart';
import 'package:tencent_im_plugin/entity/node_video_entity.dart';
import 'package:tencent_im_plugin_example/page/im.dart';

/// 消息列表
class ImList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ImListState();
}

class ImListState extends State<ImList> {
  /// 刷新加载器
  GlobalKey<RefreshIndicatorState> refreshIndicator = GlobalKey();

  /// 会话列表
  List<SessionEntity> data = [];

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
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
    if (type == ListenerTypeEnum.RefreshConversation) {
      this.setState(() {
        for (var item in params) {
          bool exist = false;
          for (var i = 0; i < data.length; i++) {
            if (data[i].id == item.id) {
              data[i] = item;
              exist = true;
              break;
            }
          }
          if (!exist) {
            data.add(item);
          }
        }
        this.sort();
      });
    }
  }

  /// list排序
  sort() {
    data.sort(
      (i1, i2) => i1.message == null
          ? 0
          : i2.message == null
              ? -1
              : i2.message.timestamp.compareTo(i1.message.timestamp),
    );
  }

  Future<void> onRefresh() {
    return TencentImPlugin.getConversationList().then((res) {
      this.setState(() {
        data = res;
        this.sort();
      });
    });
  }

  /// 获得消息描述
  onGetMessageDesc(MessageEntity message) {
    if (message == null ||
        message.elemList == null ||
        message.elemList.length == 0) {
      return "";
    }

    NodeEntity node = message.elemList[0];
    if (node is NodeTextEntity) {
      return node.text;
    } else if (node is NodeImageEntity) {
      return "[图片]";
    } else if (node is NodeSoundEntity) {
      return "[语音]";
    } else if (node is NodeVideoEntity) {
      return "[视频]";
    }

    return "";
  }

  /// 点击事件
  onClick(item) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new ImPage(
          id: item.id,
          type: item.type,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      key: refreshIndicator,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: data.map(
          (item) {
            DateTime dateTime = item.message != null
                ? DateTime.fromMillisecondsSinceEpoch(
                    item.message.timestamp * 1000)
                : null;
            return InkWell(
              onTap: () => onClick(item),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: item.faceUrl == null
                      ? null
                      : Image.network(
                          item.faceUrl,
                          fit: BoxFit.cover,
                        ).image,
                ),
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.nickname == null
                            ? (item.type == SessionType.System ? "系统账号" : "")
                            : item.nickname,
                      ),
                    ),
                    Text(
                      dateTime == null
                          ? ""
                          : "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        this.onGetMessageDesc(item.message),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    item.unreadMessageNum != 0
                        ? Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.only(
                              top: 2,
                              bottom: 2,
                              left: 6,
                              right: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            child: Text(
                              "${item.unreadMessageNum}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          )
                        : Text(""),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
