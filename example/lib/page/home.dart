import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';

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
          children: data
              .map(
                (item) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: item.faceUrl == null
                        ? null
                        : Image.network(
                            item.faceUrl,
                            fit: BoxFit.cover,
                          ).image,
                  ),
                  title: Text(item.nickname == null
                      ? (item.type == SessionType.System ? "系统账号" : "")
                      : item.nickname),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
