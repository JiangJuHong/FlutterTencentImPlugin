import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/entity/group_info_entity.dart';
import 'package:tencent_im_plugin_example/page/im.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';

/// 群列表
class GroupList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GroupListState();
}

class GroupListState extends State<GroupList> {
  /// 刷新加载器
  GlobalKey<RefreshIndicatorState> refreshIndicator = GlobalKey();

  /// 数据对象
  List<GroupInfoEntity> data = [];

  @override
  initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicator.currentState.show();
    });
  }

  /// 刷新
  Future<void> onRefresh() {
    return TencentImPlugin.getGroupList().then((res) {
      this.setState(() {
        data = res;
      });
    });
  }

  /// 点击事件
  onClick(item) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new ImPage(
          id: item.groupId,
          type: SessionType.Group,
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
//        children: <Widget>[],
        children: data.map(
          (item) {
            return InkWell(
              onTap: () => onClick(item),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: Image.network(
                    item.faceUrl,
                    fit: BoxFit.cover,
                  ).image,
                ),
                title: Text(
                  item.groupName,
                ),
                subtitle: Text("${item.memberNum}人"),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
