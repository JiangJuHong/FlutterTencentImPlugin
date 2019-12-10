import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/entity/pendency_entity.dart';
import 'package:tencent_im_plugin_example/page/im.dart';
import 'package:tencent_im_plugin/entity/session_entity.dart';
import 'package:tencent_im_plugin/enums/pendency_type_enum.dart';

/// 申请列表
class ApplyList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ApplyListState();
}

class ApplyListState extends State<ApplyList> {
  /// 刷新加载器
  GlobalKey<RefreshIndicatorState> refreshIndicator = GlobalKey();

  /// 数据对象
  List<PendencyEntity> data = [];

  @override
  initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicator.currentState.show();
    });
  }

  /// 刷新
  Future<void> onRefresh() {
    return TencentImPlugin.getPendencyList(type: PendencyTypeEnum.BOTH)
        .then((res) {
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
          id: item.identifier,
          type: SessionType.C2C,
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
            DateTime dateTime =
                DateTime.fromMillisecondsSinceEpoch(item.addTime * 1000);
            return InkWell(
              onTap: () => onClick(item),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: Image.network(
                    item.userProfile.faceUrl,
                    fit: BoxFit.cover,
                  ).image,
                ),
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        item.nickname,
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
                subtitle: Text(item.addWording),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
