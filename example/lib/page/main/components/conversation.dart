import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/entity/conversation_result_entity.dart';
import 'package:tencent_im_plugin/entity/conversation_entity.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';
import 'package:tencent_im_plugin/enums/tencent_im_listener_type_enum.dart';

/// 会话页面
class Conversation extends StatefulWidget {
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  /// 刷新指示器Key
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();

  /// 会话结果对象
  ConversationResultEntity _data;

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
    if (type == TencentImListenerTypeEnum.ConversationChanged) {
      _onRefresh();
    }
  }

  /// 刷新事件
  Future<dynamic> _onRefresh() {
    return TencentImPlugin.getConversationList().then((value) {
      this.setState(() => _data = value);
    });
  }

  /// 会话点击事件
  _onConversationClick(ConversationEntity data) {
    Navigator.pushNamed(context, "/chat", arguments: data);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _onRefresh,
      child: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: _data?.conversationList == null
              ? []
              : _data.conversationList
                  .map(
                    (item) => ListTile(
                      onTap: () => _onConversationClick(item),
                      leading: CircleAvatar(backgroundImage: item.faceUrl == null || item.faceUrl == '' ? null : NetworkImage(item.faceUrl)),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: "[${item.groupID == null ? "私聊" : "群聊"}] ", style: TextStyle(color: Colors.grey)),
                            TextSpan(text: item.showName),
                          ],
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: item.draftText == null ? "" : "[草稿]", style: TextStyle(color: Colors.red)),
                            TextSpan(
                              text: item.draftText ?? item.lastMessage?.note ?? "",
                            ),
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
