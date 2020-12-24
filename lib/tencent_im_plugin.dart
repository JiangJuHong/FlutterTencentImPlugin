import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tencent_im_plugin/entity/conversation_entity.dart';
import 'package:tencent_im_plugin/entity/conversation_result_entity.dart';
import 'package:tencent_im_plugin/entity/find_friend_application_entity.dart';
import 'package:tencent_im_plugin/entity/find_group_application_entity.dart';
import 'package:tencent_im_plugin/entity/find_message_entity.dart';
import 'package:tencent_im_plugin/entity/friend_add_application_entity.dart';
import 'package:tencent_im_plugin/entity/friend_application_result_entity.dart';
import 'package:tencent_im_plugin/entity/friend_check_result_entity.dart';
import 'package:tencent_im_plugin/entity/friend_group_entity.dart';
import 'package:tencent_im_plugin/entity/friend_info_entity.dart';
import 'package:tencent_im_plugin/entity/friend_info_result_entity.dart';
import 'package:tencent_im_plugin/entity/friend_operation_result_entity.dart';
import 'package:tencent_im_plugin/entity/group_application_result_entity.dart';
import 'package:tencent_im_plugin/entity/group_create_member_entity.dart';
import 'package:tencent_im_plugin/entity/group_info_entity.dart';
import 'package:tencent_im_plugin/entity/group_info_result_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_info_result_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_operation_result_entity.dart';
import 'package:tencent_im_plugin/entity/offline_push_info_entity.dart';
import 'package:tencent_im_plugin/entity/signaling_info_entity.dart';
import 'package:tencent_im_plugin/entity/user_entity.dart';
import 'package:tencent_im_plugin/enums/friend_application_agree_type_enum.dart';
import 'package:tencent_im_plugin/enums/friend_type_enum.dart';
import 'package:tencent_im_plugin/enums/group_member_filter_enum.dart';
import 'package:tencent_im_plugin/enums/group_member_role_enum.dart';
import 'package:tencent_im_plugin/enums/group_receive_message_opt_enum.dart';
import 'package:tencent_im_plugin/enums/login_status_enum.dart';
import 'package:tencent_im_plugin/enums/message_priority_enum.dart';
import 'package:tencent_im_plugin/list_util.dart';
import 'package:tencent_im_plugin/listener/tencent_im_plugin_listener.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/enums/log_print_level.dart';

class TencentImPlugin {
  static const MethodChannel _channel =
      const MethodChannel('tencent_im_plugin');

  /// 监听器对象
  static TencentImPluginListener listener = TencentImPluginListener(_channel);

  /// C2C会话前缀
  static const String conversationC2CPrefix = "c2c_";

  /// 群聊会话前缀
  static const String conversationGroupPrefix = "group_";

  /// 初始化SDK
  /// [appid] 应用ID
  /// [logPrintLevel] 日志打印级别
  static initSDK({
    @required String appid,
    LogPrintLevel logPrintLevel,
  }) {
    return _channel.invokeMethod('initSDK', {
      "appid": appid,
      "logPrintLevel": LogPrintLevelTool.toInt(logPrintLevel),
    });
  }

  /// 反初始化SDK
  static unInitSDK() => _channel.invokeMethod('unInitSDK');

  /// 登录腾讯云IM
  /// [userID] 用户ID
  /// [userSig] 用户签名
  static login({
    @required String userID,
    @required String userSig,
  }) {
    return _channel
        .invokeMethod('login', {"userID": userID, "userSig": userSig});
  }

  /// 退出登录腾讯云IM
  static logout() => _channel.invokeMethod('logout');

  /// 获得用户登录状态
  /// [Return] 用户当前登录状态
  static Future<LoginStatusEnum> getLoginStatus() async =>
      LoginStatusTool.getByInt(await _channel.invokeMethod('getLoginStatus'));

  /// 获得当前登录用户
  /// [Return] 当前用户ID
  static Future<String> getLoginUser() => _channel.invokeMethod('getLoginUser');

  /// 邀请某个人
  /// [invitee] 被邀请人用户 ID
  /// [data] 自定义数据
  /// [onlineUserOnly] 是否只有在线用户才能收到邀请，如果设置为 true，只有在线用户才能收到， 并且 invite 操作也不会产生历史消息（针对该次 invite 的后续 cancel、accept、reject、timeout 操作也同样不会产生历史消息）。
  /// [offlinePushInfo] 离线推送信息，其中 desc 为必填字段，推送的时候会默认展示 desc 信息。
  /// [timeout] 超时时间，单位秒，如果设置为 0，SDK 不会做超时检测，也不会触发 onInvitationTimeout 回调
  /// [Return] 邀请 ID，如果邀请失败，返回 null
  static Future<String> invite({
    @required String invitee,
    @required String data,
    OfflinePushInfoEntity offlinePushInfo,
    bool onlineUserOnly: false,
    int timeout: 0,
  }) {
    return _channel.invokeMethod('invite', {
      "invitee": invitee,
      "data": data,
      "onlineUserOnly": onlineUserOnly,
      "offlinePushInfo": jsonEncode(offlinePushInfo ?? OfflinePushInfoEntity()),
      "timeout": timeout,
    });
  }

  /// 邀请群内的某些人
  /// [groupID] 发起邀请所在群组
  /// [inviteeList] 被邀请人列表，inviteeList 必须已经在 groupID 群里，否则邀请无效
  /// [data] 自定义数据
  /// [onlineUserOnly] 是否只有在线用户才能收到邀请，如果设置为 true，只有在线用户才能收到， 并且 invite 操作也不会产生历史消息（针对该次 invite 的后续 cancel、accept、reject、timeout 操作也同样不会产生历史消息）。
  /// [timeout] 超时时间，单位秒，如果设置为 0，SDK 不会做超时检测，也不会触发 onInvitationTimeout 回调
  /// [Return] 邀请 ID，如果邀请失败，返回 null
  static Future<String> inviteInGroup({
    @required String groupID,
    @required List<String> inviteeList,
    @required String data,
    bool onlineUserOnly: false,
    int timeout: 0,
  }) {
    return _channel.invokeMethod('inviteInGroup', {
      "groupID": groupID,
      "inviteeList": inviteeList.join(","),
      "data": data,
      "onlineUserOnly": onlineUserOnly,
      "timeout": timeout,
    });
  }

  /// 邀请方取消邀请
  /// [inviteID] 邀请ID
  /// [data] 自定义数据
  static Future<String> cancel({
    @required String inviteID,
    @required String data,
  }) {
    return _channel.invokeMethod('cancel', {
      "inviteID": inviteID,
      "data": data,
    });
  }

  /// 接收方接收邀请
  /// [inviteID] 邀请ID
  /// [data] 自定义数据
  static Future<String> accept({
    @required String inviteID,
    @required String data,
  }) {
    return _channel.invokeMethod('accept', {
      "inviteID": inviteID,
      "data": data,
    });
  }

  /// 接收方拒绝邀请
  /// [inviteID] 邀请ID
  /// [data] 自定义数据
  static Future<String> reject({
    @required String inviteID,
    @required String data,
  }) {
    return _channel.invokeMethod('reject', {
      "inviteID": inviteID,
      "data": data,
    });
  }

  /// 获取信令信息
  /// [message] 消息对象
  /// [Return] V2TIMSignalingInfo 信令信息，如果为 null，则 msg 不是一条信令消息。
  static Future<SignalingInfoEntity> getSignalingInfo({
    @required FindMessageEntity message,
  }) async {
    return SignalingInfoEntity.fromJson(
        jsonDecode(await _channel.invokeMethod('getSignalingInfo', {
      "message": jsonEncode(message),
    })));
  }

  /// 添加邀请信令（可以用于群离线推送消息触发的邀请信令）
  /// [info] 信令信息对象
  static addInvitedSignaling({
    @required SignalingInfoEntity info,
  }) {
    return _channel.invokeMethod('addInvitedSignaling', {
      "info": jsonEncode(info),
    });
  }

  /// 发送消息
  /// [receiver] 消息接收者的 userID, 如果是发送 C2C 单聊消息，只需要指定 receiver 即可。
  /// [groupID] 目标群组 ID，如果是发送群聊消息，只需要指定 groupID 即可。
  /// [ol] 是否为在线消息(无痕)，如果为true，将使用 sendOnlineMessage 通道进行消息发送
  /// [localCustomInt] 自定义Int
  /// [localCustomStr] 自定义Str
  /// [node] 消息节点
  /// [atUserList] 需要 @ 的用户列表，暂不支持直接@ALL
  /// [priority] 消息优先级，仅针对群聊消息有效。请把重要消息设置为高优先级（比如红包、礼物消息），高频且不重要的消息设置为低优先级（比如点赞消息）。
  /// [offlinePushInfo] 离线推送时携带的标题和内容。
  /// [Return] 消息ID
  static Future<String> sendMessage({
    String receiver,
    String groupID,
    @required MessageNode node,
    bool ol: false,
    int localCustomInt,
    String localCustomStr,
    MessagePriorityEnum priority: MessagePriorityEnum.Default,
    OfflinePushInfoEntity offlinePushInfo,
  }) {
    return _channel.invokeMethod(
      'sendMessage',
      {
        "receiver": receiver,
        "groupID": groupID,
        "node": jsonEncode(node),
        "ol": ol,
        "localCustomInt": localCustomInt,
        "localCustomStr": localCustomStr,
        "priority": MessagePriorityTool.toInt(priority),
        "offlinePushInfo":
            offlinePushInfo == null ? null : jsonEncode(offlinePushInfo),
      }..removeWhere((key, value) => value == null),
    );
  }

  /// 撤回消息
  /// [message] 消息查找对象
  static revokeMessage({
    @required FindMessageEntity message,
  }) {
    return _channel.invokeMethod('revokeMessage', {
      "message": jsonEncode(message),
    });
  }

  /// 获得历史记录，此方法为 getC2CHistoryMessageList + getGroupHistoryMessageList 提供的统一封装方法，(userID 和 group) 不能都为空
  /// [userId] 用户ID
  /// [groupID] 群聊ID
  /// [count] 拉取消息的个数，不宜太多，会影响消息拉取的速度，这里建议一次拉取 20 个
  /// [lastMsg] 获取消息的起始消息，如果传 null，起始消息为会话的最新消息
  static Future<List<MessageEntity>> getHistoryMessageList({
    String userID,
    String groupID,
    @required int count,
    FindMessageEntity lastMsg,
  }) {
    if (userID == null && groupID == null)
      throw ArgumentError("userID 和 groupID 不能同时为空!");
    if (userID != null) {
      return getC2CHistoryMessageList(
          userID: userID, count: count, lastMsg: lastMsg);
    } else {
      return getGroupHistoryMessageList(
          groupID: groupID, count: count, lastMsg: lastMsg);
    }
  }

  /// 获得单聊历史记录
  /// [userId] 用户ID
  /// [count] 拉取消息的个数，不宜太多，会影响消息拉取的速度，这里建议一次拉取 20 个
  /// [lastMsg] 获取消息的起始消息，如果传 null，起始消息为会话的最新消息
  static Future<List<MessageEntity>> getC2CHistoryMessageList({
    @required String userID,
    @required int count,
    FindMessageEntity lastMsg,
  }) async {
    return ListUtil.generateOBJList<MessageEntity>(
        jsonDecode(await _channel.invokeMethod(
      'getC2CHistoryMessageList',
      {
        "userID": userID,
        "count": count,
        "lastMsg": lastMsg == null ? null : jsonEncode(lastMsg),
      }..removeWhere((key, value) => value == null),
    )));
  }

  /// 获得群聊历史记录
  /// [groupID] 群ID
  /// [count] 拉取消息的个数，不宜太多，会影响消息拉取的速度，这里建议一次拉取 20 个
  /// [lastMsg] 获取消息的起始消息，如果传 null，起始消息为会话的最新消息
  static Future<List<MessageEntity>> getGroupHistoryMessageList({
    @required String groupID,
    @required int count,
    FindMessageEntity lastMsg,
  }) async {
    return ListUtil.generateOBJList<MessageEntity>(
        jsonDecode(await _channel.invokeMethod(
      'getGroupHistoryMessageList',
      {
        "groupID": groupID,
        "count": count,
        "lastMsg": lastMsg == null ? null : jsonEncode(lastMsg),
      }..removeWhere((key, value) => value == null),
    )));
  }

  /// 设置聊天记录为已读，此为 markC2CMessageAsRead 和 markGroupMessageAsRead 的封装
  /// [userID] 用户ID
  /// [groupID] 群ID
  static markMessageAsRead({
    String userID,
    String groupID,
  }) {
    if (userID == null && groupID == null)
      throw ArgumentError("userID 和 groupID 不能同时为空!");
    if (userID != null) {
      return markC2CMessageAsRead(userID: userID);
    } else {
      return markGroupMessageAsRead(groupID: groupID);
    }
  }

  /// 设置单聊已读
  /// [groupID] 群ID
  static markC2CMessageAsRead({
    @required String userID,
  }) {
    return _channel.invokeMethod('markC2CMessageAsRead', {
      "userID": userID,
    });
  }

  /// 设置群聊已读
  /// [groupID] 群ID
  static markGroupMessageAsRead({
    @required String groupID,
  }) {
    return _channel.invokeMethod('markGroupMessageAsRead', {
      "groupID": groupID,
    });
  }

  /// 删除本地消息
  /// [message] 消息对象
  static deleteMessageFromLocalStorage({
    @required FindMessageEntity message,
  }) {
    return _channel.invokeMethod('deleteMessageFromLocalStorage', {
      "message": jsonEncode(message),
    });
  }

  /// 删除本地及漫游消息
  /// 该接口会删除本地历史的同时也会把漫游消息即保存在服务器上的消息也删除，卸载重装后无法再拉取到。需要注意的是：
  ///   1. 一次最多只能删除 30 条消息
  ///   2. 要删除的消息必须属于同一会话
  ///   3. 一秒钟最多只能调用一次该接口
  ///   4. 如果该账号在其他设备上拉取过这些消息，那么调用该接口删除后，这些消息仍然会保存在那些设备上，即删除消息不支持多端同步。
  /// [message] 消息对象
  static deleteMessages({
    @required List<FindMessageEntity> message,
  }) {
    return _channel.invokeMethod('deleteMessages', {
      "message": jsonEncode(message),
    });
  }

  /// 向群组消息列表中添加一条消息
  /// [groupID] 群ID
  /// [sender] 发送人
  /// [message] 消息对象
  static insertGroupMessageToLocalStorage({
    @required String groupID,
    @required String sender,
    @required MessageNode node,
  }) {
    return _channel.invokeMethod('insertGroupMessageToLocalStorage', {
      "groupID": groupID,
      "sender": sender,
      "node": jsonEncode(node),
    });
  }

  /// 下载视频
  /// [message] 消息对象
  /// [path] 下载路径
  static downloadVideo({
    @required FindMessageEntity message,
    @required String path,
  }) {
    return _channel.invokeMethod('downloadVideo', {
      "message": jsonEncode(message),
      "path": path,
    });
  }

  /// 下载视频缩略图
  /// [message] 消息对象
  /// [path] 下载路径
  static downloadVideoThumbnail({
    @required FindMessageEntity message,
    @required String path,
  }) {
    return _channel.invokeMethod('downloadVideoThumbnail', {
      "message": jsonEncode(message),
      "path": path,
    });
  }

  /// 下载语音
  /// [message] 消息对象
  /// [path] 下载路径
  static downloadSound({
    @required FindMessageEntity message,
    @required String path,
  }) {
    return _channel.invokeMethod('downloadSound', {
      "message": jsonEncode(message),
      "path": path,
    });
  }

  /// 设置消息本地Str
  /// [message] 消息对象
  /// [data] 数据对象
  static setMessageLocalCustomStr({
    @required FindMessageEntity message,
    @required String data,
  }) {
    return _channel.invokeMethod('setMessageLocalCustomStr', {
      "message": jsonEncode(message),
      "data": data,
    });
  }

  /// 设置消息本地Int
  /// [message] 消息对象
  /// [data] 数据对象
  static setMessageLocalCustomInt({
    @required FindMessageEntity message,
    @required int data,
  }) {
    return _channel.invokeMethod('setMessageLocalCustomInt', {
      "message": jsonEncode(message),
      "data": data,
    });
  }

  /// 创建群
  /// [info] 群信息对象
  /// [memberList] 指定初始的群成员（直播群 AVChatRoom 不支持指定初始群成员，memberList 请传 null）
  /// [Return] 群ID
  static Future<String> createGroup({
    @required GroupInfoEntity info,
    List<GroupCreateMemberEntity> memberList,
  }) {
    return _channel.invokeMethod(
      'createGroup',
      {
        "info": jsonEncode(info),
        "memberList": memberList == null ? null : jsonEncode(memberList),
      }..removeWhere((key, value) => value == null),
    );
  }

  /// 加入群
  /// [groupID] 群ID
  /// [message] 描述
  static joinGroup({
    @required String groupID,
    @required String message,
  }) {
    return _channel.invokeMethod('joinGroup', {
      "groupID": groupID,
      "message": message,
    });
  }

  /// 退出群
  /// [groupID] 群ID
  static quitGroup({
    @required String groupID,
  }) {
    return _channel.invokeMethod('quitGroup', {
      "groupID": groupID,
    });
  }

  /// 解散群
  /// [groupID] 群ID
  static dismissGroup({
    @required String groupID,
  }) {
    return _channel.invokeMethod('dismissGroup', {
      "groupID": groupID,
    });
  }

  /// 获取已经加入的群列表（不包括已加入的直播群）
  static Future<List<GroupInfoEntity>> getJoinedGroupList() async {
    return ListUtil.generateOBJList<GroupInfoEntity>(
        jsonDecode(await _channel.invokeMethod('getJoinedGroupList')));
  }

  /// 拉取群资料
  /// [groupIDList] 群ID列表
  static Future<List<GroupInfoResultEntity>> getGroupsInfo({
    @required List<String> groupIDList,
  }) async {
    return ListUtil.generateOBJList<GroupInfoResultEntity>(
        jsonDecode(await _channel.invokeMethod('getGroupsInfo', {
      "groupIDList": groupIDList.join(","),
    })));
  }

  /// 修改群资料
  /// [info] 群信息
  static setGroupInfo({
    @required GroupInfoEntity info,
  }) async {
    return _channel.invokeMethod('setGroupInfo', {
      "info": jsonEncode(info),
    });
  }

  /// 修改群消息接收选项
  /// [groupID] 群ID
  /// [opt] 消息接收选项
  static setReceiveMessageOpt({
    @required String groupID,
    @required GroupReceiveMessageOptEnum opt,
  }) async {
    return _channel.invokeMethod('setReceiveMessageOpt', {
      "groupID": groupID,
      "opt": GroupReceiveMessageOptTool.toInt(opt),
    });
  }

  /// 初始化群属性，会清空原有的群属性列表
  /// [groupID] 群ID
  /// [attributes] 群属性
  ///   1. attributes 的使用限制如下：
  ///   2. 目前只支持 AVChatRoom
  ///   3. key 最多支持16个，长度限制为32字节
  ///   4. value 长度限制为4k
  ///   5. 总的 attributes（包括 key 和 value）限制为16k
  ///   6. initGroupAttributes、setGroupAttributes、deleteGroupAttributes 接口合并计算， SDK 限制为5秒10次，超过后回调8511错误码；后台限制1秒5次，超过后返回10049错误码
  ///   7. getGroupAttributes 接口 SDK 限制5秒20次
  static initGroupAttributes({
    @required String groupID,
    @required Map<String, String> attributes,
  }) async {
    return _channel.invokeMethod('initGroupAttributes', {
      "groupID": groupID,
      "attributes": jsonEncode(attributes),
    });
  }

  /// 设置群属性。已有该群属性则更新其 value 值，没有该群属性则添加该属性。
  /// [groupID] 群ID
  /// [attributes] 群属性
  static setGroupAttributes({
    @required String groupID,
    @required Map<String, String> attributes,
  }) async {
    return _channel.invokeMethod('setGroupAttributes', {
      "groupID": groupID,
      "attributes": jsonEncode(attributes),
    });
  }

  /// 删除指定群属性，keys 传 null 则清空所有群属性。
  /// [groupID] 群ID
  /// [keys] 群属性Key,keys 传 null 则清空所有群属性。
  static deleteGroupAttributes({
    @required String groupID,
    List<String> keys,
  }) async {
    return _channel.invokeMethod(
      'deleteGroupAttributes',
      {
        "groupID": groupID,
        "keys": keys == null ? null : keys.join(","),
      }..removeWhere((key, value) => value == null),
    );
  }

  /// 获取指定群属性，keys 传 null 则获取所有群属性。
  /// [groupID] 群ID
  /// [keys] 群属性Key,keys 传 null 则清空所有群属性。
  static Future<Map<String, String>> getGroupAttributes({
    @required String groupID,
    List<String> keys,
  }) async {
    return (jsonDecode(await _channel.invokeMethod(
      'getGroupAttributes',
      {
        "groupID": groupID,
        "keys": keys == null ? null : keys.join(","),
      }..removeWhere((key, value) => value == null),
    )) as Map)
        .cast<String, String>();
  }

  /// 获取指定群在线人数
  /// [groupID] 群ID
  static Future<int> getGroupOnlineMemberCount({
    @required String groupID,
  }) {
    return _channel.invokeMethod('getGroupOnlineMemberCount', {
      "groupID": groupID,
    });
  }

  /// 获取群成员列表。
  /// [groupID] 群ID
  /// [filter] 指定群成员类型
  /// [nextSeq] 分页拉取标志，第一次拉取填0，回调成功如果 nextSeq 不为零，需要分页，传入再次拉取，直至为0。
  static Future<GroupMemberInfoResultEntity> getGroupMemberList({
    @required String groupID,
    GroupMemberFilterEnum filter: GroupMemberFilterEnum.All,
    int nextSeq: 0,
  }) async {
    return GroupMemberInfoResultEntity.fromJson(
        jsonDecode(await _channel.invokeMethod('getGroupMemberList', {
      "groupID": groupID,
      "filter": GroupMemberFilterTool.toInt(filter),
      "nextSeq": nextSeq,
    })));
  }

  /// 获取指定的群成员资料。
  /// [groupID] 群ID
  /// [memberList] 群成员列表
  static Future<List<GroupMemberEntity>> getGroupMembersInfo({
    @required String groupID,
    @required List<String> memberList,
  }) async {
    return ListUtil.generateOBJList<GroupMemberEntity>(
        jsonDecode(await _channel.invokeMethod('getGroupMembersInfo', {
      "groupID": groupID,
      "memberList": memberList.join(","),
    })));
  }

  /// 修改指定的群成员资料。
  /// [groupID] 群ID
  /// [info] 群成员对象
  static setGroupMemberInfo({
    @required String groupID,
    @required GroupMemberEntity info,
  }) {
    return _channel.invokeMethod('setGroupMemberInfo', {
      "groupID": groupID,
      "info": jsonEncode(info),
    });
  }

  /// 禁言（只有管理员或群主能够调用）。
  /// [groupID] 群ID
  /// [userID] 用户ID
  /// [seconds] 禁言时长
  static muteGroupMember({
    @required String groupID,
    @required String userID,
    @required int seconds,
  }) {
    return _channel.invokeMethod('muteGroupMember', {
      "groupID": groupID,
      "userID": userID,
      "seconds": seconds,
    });
  }

  /// 邀请他人入群
  /// [groupID] 群ID
  /// [userList] 用户ID列表
  static Future<List<GroupMemberOperationResultEntity>> inviteUserToGroup({
    @required String groupID,
    @required List<String> userList,
  }) async {
    return ListUtil.generateOBJList<GroupMemberOperationResultEntity>(
        jsonDecode(await _channel.invokeMethod('inviteUserToGroup', {
      "groupID": groupID,
      "userList": userList.join(","),
    })));
  }

  /// 踢人
  /// [groupID] 群ID
  /// [memberList] 群成员ID列表
  /// [reason] 理由
  static Future<List<GroupMemberOperationResultEntity>> kickGroupMember({
    @required String groupID,
    @required List<String> memberList,
    String reason: "",
  }) async {
    return ListUtil.generateOBJList<GroupMemberOperationResultEntity>(
        jsonDecode(await _channel.invokeMethod('kickGroupMember', {
      "groupID": groupID,
      "memberList": memberList.join(","),
      "reason": reason,
    })));
  }

  /// 切换群成员的角色。
  /// [groupID] 群ID
  /// [userID] 用户ID
  /// [role] 角色
  static setGroupMemberRole({
    @required String groupID,
    @required String userID,
    @required GroupMemberRoleEnum role,
  }) {
    return _channel.invokeMethod('setGroupMemberRole', {
      "groupID": groupID,
      "userID": userID,
      "role": GroupMemberRoleTool.toInt(role),
    });
  }

  /// 转让群主
  /// [groupID] 群ID
  /// [userID] 用户ID
  static transferGroupOwner({
    @required String groupID,
    @required String userID,
  }) {
    return _channel.invokeMethod('transferGroupOwner', {
      "groupID": groupID,
      "userID": userID,
    });
  }

  /// 获取加群的申请列表
  static Future<GroupApplicationResultEntity> getGroupApplicationList() async {
    return GroupApplicationResultEntity.fromJson(
        jsonDecode(await _channel.invokeMethod('getGroupApplicationList')));
  }

  /// 同意某一条加群申请
  /// [application] 申请对象
  /// [reason] 理由
  static acceptGroupApplication({
    @required FindGroupApplicationEntity application,
    String reason: "",
  }) {
    return _channel.invokeMethod('acceptGroupApplication', {
      "application": jsonEncode(application),
      "reason": reason,
    });
  }

  /// 拒绝某一条加群申请
  /// [application] 申请对象
  /// [reason] 理由
  static refuseGroupApplication({
    @required FindGroupApplicationEntity application,
    String reason: "",
  }) {
    return _channel.invokeMethod('refuseGroupApplication', {
      "application": jsonEncode(application),
      "reason": reason,
    });
  }

  /// 标记申请列表为已读
  static setGroupApplicationRead() {
    return _channel.invokeMethod('setGroupApplicationRead');
  }

  /// 获取会话列表
  /// [nextSeq] 分页拉取的游标，第一次默认取传 0，后续分页拉传上一次分页拉取成功回调里的 nextSeq
  /// [count] 分页拉取的个数，一次分页拉取不宜太多，会影响拉取的速度，建议每次拉取 100 个会话
  static Future<ConversationResultEntity> getConversationList({
    int nextSeq: 0,
    int count: 100,
  }) async {
    return ConversationResultEntity.fromJson(
        jsonDecode(await _channel.invokeMethod('getConversationList', {
      "nextSeq": nextSeq,
      "count": count,
    })));
  }

  /// 获得指定会话（[conversationID] | [userID] | [groupID] 参数三选一）
  /// [conversationID] 会话ID
  /// [userID] 用户ID
  /// [groupID] 群ID
  static Future<ConversationEntity> getConversation({
    String conversationID,
    String userID,
    String groupID,
  }) async {
    String cID = conversationID;
    if (cID == null && userID != null) {
      cID = conversationC2CPrefix + userID;
    } else if (cID == null && groupID != null) {
      cID = conversationGroupPrefix + groupID;
    }
    return ConversationEntity.fromJson(
        jsonDecode(await _channel.invokeMethod('getConversation', {
      "conversationID": cID,
    })));
  }

  /// 删除会话（[conversationID] | [userID] | [groupID] 参数三选一）
  /// [conversationID] 会话ID
  /// [userID] 用户ID
  /// [groupID] 群ID
  static deleteConversation({
    String conversationID,
    String userID,
    String groupID,
  }) {
    String cID = conversationID;
    if (cID == null && userID != null) {
      cID = conversationC2CPrefix + userID;
    } else if (cID == null && groupID != null) {
      cID = conversationGroupPrefix + groupID;
    }
    return _channel.invokeMethod('deleteConversation', {
      "conversationID": cID,
    });
  }

  /// 设置会话草稿（[conversationID] | [userID] | [groupID] 参数三选一）
  /// [conversationID] 会话ID
  /// [userID] 用户ID
  /// [groupID] 群ID
  /// [draftText] 草稿内容，null代表取消设置
  static setConversationDraft({
    String conversationID,
    String userID,
    String groupID,
    String draftText,
  }) {
    String cID = conversationID;
    if (cID == null && userID != null) {
      cID = conversationC2CPrefix + userID;
    } else if (cID == null && groupID != null) {
      cID = conversationGroupPrefix + groupID;
    }
    return _channel.invokeMethod(
      'setConversationDraft',
      {
        "conversationID": cID,
        "draftText": draftText,
      }..removeWhere((key, value) => value == null),
    );
  }

  /// 获取用户资料
  /// [userList] 用户ID列表
  static Future<List<UserEntity>> getUsersInfo({
    @required List<String> userIDList,
  }) async {
    return ListUtil.generateOBJList<UserEntity>(
        jsonDecode(await _channel.invokeMethod('getUsersInfo', {
      "userIDList": userIDList.join(","),
    })));
  }

  /// 修改个人资料
  /// [info] 资料对象
  static setSelfInfo({
    @required UserEntity info,
  }) {
    return _channel.invokeMethod('setSelfInfo', {
      "info": jsonEncode(info),
    });
  }

  /// 添加用户到黑名单
  /// [userIDList] 用户ID列表
  static Future<List<FriendOperationResultEntity>> addToBlackList({
    @required List<String> userIDList,
  }) async {
    return ListUtil.generateOBJList<FriendOperationResultEntity>(
        jsonDecode(await _channel.invokeMethod('addToBlackList', {
      "userIDList": userIDList.join(","),
    })));
  }

  /// 从黑名单中删除
  /// [userIDList] 用户ID列表
  static Future<List<FriendOperationResultEntity>> deleteFromBlackList({
    @required List<String> userIDList,
  }) async {
    return ListUtil.generateOBJList<FriendOperationResultEntity>(
        jsonDecode(await _channel.invokeMethod('deleteFromBlackList', {
      "userIDList": userIDList.join(","),
    })));
  }

  /// 获得黑名单列表
  static Future<List<FriendInfoEntity>> getBlackList() async {
    return ListUtil.generateOBJList<FriendInfoEntity>(
        jsonDecode(await _channel.invokeMethod('getBlackList')));
  }

  /// 设置离线推送Token,Android使用setOfflinePushConfig，IOS使用setAPNS
  /// [token] Token
  /// [bussid] 推送证书 ID，是在 IM 控制台上生成的
  static setOfflinePushConfig({
    @required String token,
    @required int bussid,
  }) {
    return _channel.invokeMethod('setOfflinePushConfig', {
      "token": token,
      "bussid": bussid,
    });
  }

  /// 设置未读桌标，Android使用doBackground，IOS更改setAPNSListener值
  /// [number] 桌标数量
  static setUnreadBadge({
    @required int number,
  }) {
    return _channel.invokeMethod('setUnreadBadge', {
      "number": number,
    });
  }

  /// 获得好友列表
  static Future<List<FriendInfoEntity>> getFriendList() async {
    return ListUtil.generateOBJList<FriendInfoEntity>(
        jsonDecode(await _channel.invokeMethod('getFriendList')));
  }

  /// 获得指定好友信息
  /// [userIDList] 好友ID列表
  static Future<List<FriendInfoResultEntity>> getFriendsInfo({
    @required List<String> userIDList,
  }) async {
    return ListUtil.generateOBJList<FriendInfoResultEntity>(
        jsonDecode(await _channel.invokeMethod('getFriendsInfo', {
      "userIDList": userIDList.join(","),
    })));
  }

  /// 设置好友资料
  /// [info] 好友资料
  static setFriendInfo({
    @required FriendInfoEntity info,
  }) {
    return _channel.invokeMethod('setFriendInfo', {
      "info": jsonEncode(info),
    });
  }

  /// 添加好友
  /// [info] 申请对象
  static Future<FriendOperationResultEntity> addFriend({
    @required FriendAddApplicationEntity info,
  }) async {
    return FriendOperationResultEntity.fromJson(
        jsonDecode(await _channel.invokeMethod('addFriend', {
      "info": jsonEncode(info),
    })));
  }

  /// 删除好友
  /// [userIDList] 好友ID列表，ID 建议一次最大 100 个，因为数量过多可能会导致数据包太大被后台拒绝，后台限制数据包最大为 1M
  /// [deleteType] 删除类型
  static Future<List<FriendOperationResultEntity>> deleteFromFriendList({
    @required List<String> userIDList,
    @required FriendTypeEnum deleteType,
  }) async {
    return ListUtil.generateOBJList<FriendOperationResultEntity>(
        jsonDecode(await _channel.invokeMethod('deleteFromFriendList', {
      "userIDList": userIDList.join(","),
      "deleteType": FriendTypeTool.toInt(deleteType),
    })));
  }

  /// 检查好友关系
  /// [userID] 用户ID
  /// [checkType] 检测类型类型
  static Future<FriendCheckResultEntity> checkFriend({
    @required String userID,
    @required FriendTypeEnum checkType,
  }) async {
    return FriendCheckResultEntity.fromJson(
        jsonDecode(await _channel.invokeMethod('checkFriend', {
      "userID": userID,
      "checkType": FriendTypeTool.toInt(checkType),
    })));
  }

  /// 获取好友申请列表
  static Future<FriendApplicationResultEntity>
      getFriendApplicationList() async {
    return FriendApplicationResultEntity.fromJson(
        jsonDecode(await _channel.invokeMethod('getFriendApplicationList')));
  }

  /// 同意好友申请
  /// [application] 查找好友申请对象实体
  /// [responseType] 建立关系类型
  static Future<FriendOperationResultEntity> acceptFriendApplication({
    @required FindFriendApplicationEntity application,
    @required FriendApplicationAgreeTypeEnum responseType,
  }) async {
    return FriendOperationResultEntity.fromJson(
        jsonDecode(await _channel.invokeMethod('acceptFriendApplication', {
      "application": jsonEncode(application),
      "responseType": FriendApplicationAgreeTypeTool.toInt(responseType),
    })));
  }

  /// 拒绝好友申请
  /// [application] 查找好友申请对象实体
  static Future<FriendOperationResultEntity> refuseFriendApplication({
    @required FindFriendApplicationEntity application,
  }) async {
    return FriendOperationResultEntity.fromJson(
        jsonDecode(await _channel.invokeMethod('refuseFriendApplication', {
      "application": jsonEncode(application),
    })));
  }

  /// 删除好友申请
  /// [application] 查找好友申请对象实体
  static deleteFriendApplication({
    @required FindFriendApplicationEntity application,
  }) {
    return _channel.invokeMethod('deleteFriendApplication', {
      "application": jsonEncode(application),
    });
  }

  /// 设置好友申请为已读
  static setFriendApplicationRead() {
    return _channel.invokeMethod('setFriendApplicationRead');
  }

  /// 新建好友分组
  /// [groupName] 组名
  /// [userIDList] 用户列表
  static Future<List<FriendOperationResultEntity>> createFriendGroup({
    @required String groupName,
    @required List<String> userIDList,
  }) async {
    return ListUtil.generateOBJList<FriendOperationResultEntity>(
        jsonDecode(await _channel.invokeMethod('createFriendGroup', {
      "groupName": groupName,
      "userIDList": userIDList.join(","),
    })));
  }

  /// 获取分组信息
  /// [groupNameList] 分组名称
  static Future<List<FriendGroupEntity>> getFriendGroups({
    List<String> groupNameList,
  }) async {
    return ListUtil.generateOBJList<FriendGroupEntity>(
        jsonDecode(await _channel.invokeMethod(
      'getFriendGroups',
      {
        "groupNameList": groupNameList?.join(","),
      }..removeWhere((key, value) => value == null),
    )));
  }

  /// 删除好友分组
  /// [groupNameList] 分组名称
  static deleteFriendGroup({
    @required List<String> groupNameList,
  }) {
    return _channel.invokeMethod('deleteFriendGroup', {
      "groupNameList": groupNameList.join(","),
    });
  }

  /// 修改分组名称
  /// [oldName] 旧名称
  /// [newName] 新名称
  static renameFriendGroup({
    @required String oldName,
    @required String newName,
  }) {
    return _channel.invokeMethod('renameFriendGroup', {
      "oldName": oldName,
      "newName": newName,
    });
  }

  /// 添加好友到分组
  /// [groupName] 组名
  /// [userIDList] 好友ID
  static Future<List<FriendOperationResultEntity>> addFriendsToFriendGroup({
    @required String groupName,
    @required List<String> userIDList,
  }) async {
    return ListUtil.generateOBJList<FriendOperationResultEntity>(
        jsonDecode(await _channel.invokeMethod('addFriendsToFriendGroup', {
      "groupName": groupName,
      "userIDList": userIDList.join(","),
    })));
  }

  /// 从分组中删除好友
  /// [groupName] 组名
  /// [userIDList] 好友ID
  static Future<List<FriendOperationResultEntity>>
      deleteFriendsFromFriendGroup({
    @required String groupName,
    @required List<String> userIDList,
  }) async {
    return ListUtil.generateOBJList<FriendOperationResultEntity>(
        jsonDecode(await _channel.invokeMethod('deleteFriendsFromFriendGroup', {
      "groupName": groupName,
      "userIDList": userIDList.join(","),
    })));
  }

  /// 添加消息监听
  static addListener(TencentImListenerValue func) => listener.addListener(func);

  /// 移除消息监听
  static removeListener(TencentImListenerValue func) =>
      listener.removeListener(func);
}
