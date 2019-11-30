import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/entity/node_entity.dart';
import 'package:tencent_im_plugin/entity/node_text_entity.dart';
import 'package:tencent_im_plugin/entity/node_image_entity.dart';

/// 首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
  }

  Future<void> onRefresh() {
    return TencentImPlugin.getConversationList().then((res) {
      this.setState(() {
        data = res;
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
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页(会话列表)"),
      ),
      body: RefreshIndicator(
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
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: item.faceUrl == null
                      ? null
                      : Image.network(
                          item.faceUrl,
                          fit: BoxFit.cover,
                        ).image,
                ),
                title: Text(
                  item.nickname == null
                      ? (item.type == SessionType.System ? "系统账号" : "")
                      : item.nickname,
                ),
                subtitle: Text(this.onGetMessageDesc(item.message)),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      dateTime == null
                          ? ""
                          : "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}",
                      style: TextStyle(
                        color: Colors.grey,
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
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
