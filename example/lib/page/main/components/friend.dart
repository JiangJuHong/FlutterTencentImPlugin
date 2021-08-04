import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/entity/friend_info_entity.dart';
import 'package:tencent_im_plugin/enums/tencent_im_listener_type_enum.dart';
import 'package:tencent_im_plugin/enums/friend_application_agree_type_enum.dart';
import 'package:tencent_im_plugin/entity/friend_application_result_entity.dart';
import 'package:tencent_im_plugin/entity/find_friend_application_entity.dart';

/// 好友页面
class Friend extends StatefulWidget {
  @override
  _FriendState createState() => _FriendState();
}

class _FriendState extends State<Friend> {
  /// 刷新指示器Key
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();

  /// 数据结果对象
  List<FriendInfoEntity> _data = [];

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
  _imListener(type, params) {
    if (type == TencentImListenerTypeEnum.FriendListAdded) {
      this.setState(() {});
    }
  }

  /// 刷新事件
  Future<dynamic> _onRefresh() {
    return TencentImPlugin.getFriendList().then((value) => this.setState(() => _data = value));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      child: Column(
        children: [
          Center(child: Padding(padding: const EdgeInsets.all(20.0), child: Text("好友申请列表"))),
          SingleChildScrollView(
            child: FutureBuilder(
              future: TencentImPlugin.getFriendApplicationList(),
              builder: (BuildContext context, AsyncSnapshot<FriendApplicationResultEntity> snapshot) {
                if (snapshot.connectionState != ConnectionState.done) return Center(child: Padding(padding: const EdgeInsets.all(20.0), child: Text("正在拉取好友申请列表")));
                if (snapshot.data.friendApplicationList.length == 0) return Center(child: Padding(padding: const EdgeInsets.all(20.0), child: Text("暂无待处理好友申请")));
                return Column(
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: snapshot.data.friendApplicationList
                        .map(
                          (item) => ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: item.nickname == null || item.nickname == '' ? item.userID : item.nickname),
                                      ],
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    RaisedButton(
                                      onPressed: () async {
                                        Future result = TencentImPlugin.acceptFriendApplication(application: FindFriendApplicationEntity.fromFriendApplicationEntity(item), responseType: FriendApplicationAgreeTypeEnum.AgreeAndAdd);
                                        await result.then((value) => Fluttertoast.showToast(msg: "处理成功!")).catchError((e) => Fluttertoast.showToast(msg: "处理失败!"));
                                        if (this.mounted) this.setState(() {});
                                      },
                                      child: Text("同意"),
                                    ),
                                    RaisedButton(
                                      onPressed: () async {
                                        Future result = TencentImPlugin.refuseFriendApplication(application: FindFriendApplicationEntity.fromFriendApplicationEntity(item));
                                        await result.then((value) => Fluttertoast.showToast(msg: "处理成功!")).catchError((e) => Fluttertoast.showToast(msg: "处理失败!"));
                                        if (this.mounted) this.setState(() {});
                                      },
                                      child: Text("拒绝"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ).toList(),
                );
              },
            ),
          ),
          Center(child: Padding(padding: const EdgeInsets.all(20.0), child: Text("好友列表"))),
          Expanded(
            child: ListView(
              children: ListTile.divideTiles(
                context: context,
                tiles: _data
                    .map(
                      (item) => ListTile(
                        leading: CircleAvatar(backgroundImage: item.userProfile?.faceUrl == null || item.userProfile.faceUrl == '' ? null : NetworkImage(item.userProfile.faceUrl)),
                        title: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: item.userProfile.nickName == null || item.userProfile.nickName == '' ? item.userID : item.userProfile.nickName),
                            ],
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
