import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/entity/group_info_entity.dart';

/// 群组列表
class Group extends StatefulWidget {
  @override
  _GroupState createState() => _GroupState();
}

class _GroupState extends State<Group> {
  /// 刷新指示器Key
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();

  /// 数据结果对象
  List<GroupInfoEntity> _data = [];

  @override
  void initState() {
    super.initState();
    TencentImPlugin.addListener(_imListener);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState.show();
    });
  }

  @override
  void dispose() {
    super.dispose();
    TencentImPlugin.removeListener(_imListener);
  }

  /// IM监听器
  _imListener(type, params) {}

  /// 刷新事件
  Future<dynamic> _onRefresh() {
    return TencentImPlugin.getJoinedGroupList()
        .then((value) => this.setState(() => _data = value));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      child: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: _data
              .map(
                (item) => ListTile(
                  leading: CircleAvatar(
                      backgroundImage:
                          item.faceUrl == null || item.faceUrl == ''
                              ? null
                              : NetworkImage(item.faceUrl)),
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: item.groupName),
                      ],
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              )
              .toList(),
        ).toList(),
      ),
    );
  }
}
