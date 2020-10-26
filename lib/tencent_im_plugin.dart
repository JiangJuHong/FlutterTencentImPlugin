import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:tencent_im_plugin/entity/add_friend_result_entity.dart';
import 'package:tencent_im_plugin/entity/check_friend_result_entity.dart';
import 'package:tencent_im_plugin/entity/find_message_entity.dart';
import 'package:tencent_im_plugin/entity/group_pendency_page_entity.dart';
import 'package:tencent_im_plugin/entity/offline_push_info_entity.dart';
import 'package:tencent_im_plugin/entity/signaling_info_entity.dart';
import 'package:tencent_im_plugin/entity_factory.dart';
import 'package:tencent_im_plugin/enums/add_group_opt_enum.dart';
import 'package:tencent_im_plugin/enums/login_status_enum.dart';
import 'package:tencent_im_plugin/list_util.dart';
import 'package:tencent_im_plugin/message_node/message_node.dart';
import 'package:tencent_im_plugin/utils/enum_util.dart';
import 'entity/friend_entity.dart';
import 'entity/group_info_entity.dart';
import 'entity/group_member_entity.dart';
import 'entity/message_entity.dart';
import 'entity/pendency_page_entity.dart';
import 'entity/session_entity.dart';
import 'entity/user_info_entity.dart';
import 'enums/friend_add_type_enum.dart';
import 'enums/friend_check_type_enum.dart';
import 'enums/log_print_level.dart';
import 'enums/pendency_examine_type_enum.dart';
import 'enums/pendency_type_enum.dart';
import 'enums/receive_message_opt_enum.dart';

class TencentImPlugin {
  static const MethodChannel _channel = const MethodChannel('tencent_im_plugin');

  /// 监听器对象
  static TencentImPluginListener listener;

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
    return _channel.invokeMethod('login', {"userID": userID, "userSig": userSig});
  }

  /// 退出登录腾讯云IM
  static logout() => _channel.invokeMethod('logout');

  /// 获得用户登录状态
  /// [Return] 用户当前登录状态
  static Future<LoginStatusEnum> getLoginStatus() async => LoginStatusTool.getByInt(await _channel.invokeMethod('getLoginStatus'));

  /// 获得当前登录用户
  /// [Return] 当前用户ID
  static getLoginUser() => _channel.invokeMethod('getLoginUser');

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
    @required bool onlineUserOnly,
    @required OfflinePushInfoEntity offlinePushInfo,
    @required int timeout,
  }) {
    return _channel.invokeMethod('invite', {
      "invitee": invitee,
      "data": data,
      "onlineUserOnly": onlineUserOnly,
      "offlinePushInfo": offlinePushInfo.toJson(),
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
    @required bool onlineUserOnly,
    @required int timeout,
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
    return SignalingInfoEntity.fromJson(await _channel.invokeMethod('getSignalingInfo', {
      "message": message.toJson(),
    }));
  }

  /// 添加邀请信令（可以用于群离线推送消息触发的邀请信令）
  /// [info] 信令信息对象
  static addInvitedSignaling({
    @required SignalingInfoEntity info,
  }) {
    return _channel.invokeMethod('addInvitedSignaling', {
      "info": info.toJson(),
    });
  }

  /// 发送消息
  static Future<MessageEntity> sendMessage({
    @required String sessionId, // 会话ID
    @required SessionType sessionType, // 会话类型
    bool ol: false, // 是否为在线消息(无痕)，如果为true，将使用 sendOnlineMessage 通道进行消息发送
    @required MessageNode node, // 消息节点
  }) async {
    return MessageEntity.fromJson(
      jsonDecode(
        await _channel.invokeMethod(
          'sendMessage',
          {
            "sessionId": sessionId,
            "sessionType": EnumUtil.getEnumName(sessionType),
            "node": jsonEncode(node),
            "ol": ol,
          },
        ),
      ),
    );
  }

  /// 向本地消息列表中添加一条消息，但并不将其发送出去。
  static Future<MessageEntity> saveMessage({
    @required String sessionId, // 会话ID
    @required SessionType sessionType, // 会话类型
    @required MessageNode node, // 消息节点
    @required String sender, // 发送人
    @required bool isReaded, // 是否已读
  }) async {
    return MessageEntity.fromJson(
      jsonDecode(
        await _channel.invokeMethod(
          'saveMessage',
          {
            "sessionId": sessionId,
            "sessionType": EnumUtil.getEnumName(sessionType),
            "node": jsonEncode(node),
            "sender": sender,
            "isReaded": isReaded,
          },
        ),
      ),
    );
  }

  /// 获得当前登录用户会话列表
  /// @return 会话列表集合
  static Future<List<SessionEntity>> getConversationList() async {
    return ListUtil.generateOBJList<SessionEntity>(jsonDecode(await _channel.invokeMethod('getConversationList')));
  }

  /// 获得当前登录用户会话列表
  /// @return 会话列表集合
  static Future<SessionEntity> getConversation({
    @required String sessionId,
    @required SessionType sessionType,
  }) async {
    String result = await _channel.invokeMethod('getConversation', {
      "sessionId": sessionId,
      "sessionType": EnumUtil.getEnumName(sessionType),
    });
    if (result == null) {
      return null;
    }
    return SessionEntity.fromJson(jsonDecode(result));
  }

  /// 根据会话ID获得本地消息列表
  static Future<List<MessageEntity>> getLocalMessages({
    @required String sessionId, // 会话ID
    @required SessionType sessionType, // 会话类型
    @required int number, // 拉取数量
    MessageEntity lastMessage, // 最后一条消息
  }) async {
    return ListUtil.generateOBJList<MessageEntity>(jsonDecode(await _channel.invokeMethod('getLocalMessages', {
      "sessionId": sessionId,
      "sessionType": EnumUtil.getEnumName(sessionType),
      "number": number,
      "lastMessage": jsonEncode(lastMessage),
    })));
  }

  /// 根据会话ID获得消息列表
  static Future<List<MessageEntity>> getMessages({
    @required String sessionId, // 会话ID
    @required SessionType sessionType, // 会话类型
    @required int number, // 拉取数量
    MessageEntity lastMessage, // 最后一条消息
  }) async {
    return ListUtil.generateOBJList<MessageEntity>(jsonDecode(await _channel.invokeMethod('getMessages', {
      "sessionId": sessionId,
      "sessionType": EnumUtil.getEnumName(sessionType),
      "number": number,
      "lastMessage": jsonEncode(lastMessage),
    })));
  }

  /// 删除会话
  static Future<bool> deleteConversation({
    @required String sessionId, // 会话ID
    @required SessionType sessionType, // 会话类型
    bool removeCache: false, // 是否删除本地消息缓存
  }) async {
    return await _channel.invokeMethod('deleteConversation', {
      "sessionId": sessionId,
      "sessionType": EnumUtil.getEnumName(sessionType),
      "removeCache": removeCache,
    });
  }

  /// 批量删除本会话的全部本地聊天记录
  static Future<void> deleteLocalMessage({
    @required String sessionId, // 会话ID
    @required SessionType sessionType, // 会话类型
  }) async {
    return await _channel.invokeMethod('deleteLocalMessage', {
      "sessionId": sessionId,
      "sessionType": EnumUtil.getEnumName(sessionType),
    });
  }

  /// 设置会话消息为已读
  static Future<void> setRead({
    @required String sessionId,
    @required SessionType sessionType,
  }) async {
    return await _channel.invokeMethod('setRead', {
      "sessionId": sessionId,
      "sessionType": EnumUtil.getEnumName(sessionType),
    });
  }

  /// 创建群聊
  static Future<String> createGroup({
    @required String type, // 群类型，参考腾讯云IM文档，``目前支持的群类型：私有群（Private）、公开群（Public）、 聊天室（ChatRoom）、互动直播聊天室（AVChatRoom）和在线成员广播大群（BChatRoom）``
    @required String name, // 群名称
    List<GroupMemberEntity> members, // 默认群成员，根据role决定身份
    String groupId, //群ID
    String notification, //群公告
    String introduction, // 群简介
    String faceUrl, // 群头像
    AddGroupOptEnum addOption, // 加群选项
    int maxMemberNum, // 最大群成员数
    Map<String, dynamic> customInfo, // 自定义信息
  }) async {
    return await _channel.invokeMethod('createGroup', {
      "type": type,
      "name": name,
      "groupId": groupId,
      "notification": notification,
      "introduction": introduction,
      "faceUrl": faceUrl,
      "addOption": addOption == null ? null : EnumUtil.getEnumName(addOption),
      "maxMemberNum": maxMemberNum,
      "members": members == null ? null : jsonEncode(members),
      "customInfo": customInfo == null ? null : jsonEncode(customInfo),
    });
  }

  /// 邀请用户加入群组
  static Future<List<dynamic>> inviteGroupMember({
    @required String groupId, //群ID
    @required List<String> ids, // 用户集合
  }) async {
    return jsonDecode(await _channel.invokeMethod('inviteGroupMember', {
      "groupId": groupId,
      "ids": ids.join(","),
    }));
  }

  /// 申请加入群组
  static Future<void> applyJoinGroup({
    @required String groupId, //群ID
    @required String reason, //申请理由
  }) async {
    return await _channel.invokeMethod('applyJoinGroup', {
      "groupId": groupId,
      "reason": reason,
    });
  }

  /// 删除群组成员
  static Future<List<dynamic>> deleteGroupMember({
    @required String groupId, //群ID
    @required List<String> ids, // 用户I集合
    String reason, //删除理由
  }) async {
    return jsonDecode(await _channel.invokeMethod('deleteGroupMember', {
      "groupId": groupId,
      "ids": ids.join(","),
      "reason": reason,
    }));
  }

  /// 退出群组
  static Future<void> quitGroup({
    @required String groupId, //群ID
  }) async {
    return await _channel.invokeMethod('quitGroup', {
      "groupId": groupId,
    });
  }

  /// 获取群成员列表
  static Future<List<GroupMemberEntity>> getGroupMembers({
    @required String groupId, //群ID
  }) async {
    return ListUtil.generateOBJList<GroupMemberEntity>(jsonDecode(await _channel.invokeMethod('getGroupMembers', {
      "groupId": groupId,
    })));
  }

  /// 获得群列表
  static Future<List<GroupInfoEntity>> getGroupList() async {
    return ListUtil.generateOBJList<GroupInfoEntity>(jsonDecode(await _channel.invokeMethod('getGroupList')));
  }

  /// 解散群组
  static Future<void> deleteGroup({
    @required String groupId, //群ID
  }) async {
    return await _channel.invokeMethod('deleteGroup', {
      "groupId": groupId,
    });
  }

  /// 群主变更
  static Future<void> modifyGroupOwner({
    @required String groupId, //群ID
    @required String identifier, //新群主ID
  }) async {
    return await _channel.invokeMethod('modifyGroupOwner', {
      "groupId": groupId,
      "identifier": identifier,
    });
  }

  /// 获得群信息
  /// @return 群ID
  static Future<GroupInfoEntity> getGroupInfo({@required id}) async {
    final String result = await _channel.invokeMethod('getGroupInfo', {"id": id});
    if (result != null) {
      return EntityFactory.generateOBJ<GroupInfoEntity>(jsonDecode(result));
    }
    return null;
  }

  /// 修改群资料
  static Future<void> modifyGroupInfo({
    String groupName, // 群名称
    @required String groupId, //群ID
    String notification, //群公告
    String introduction, // 群简介
    String faceUrl, // 群头像
    AddGroupOptEnum addOption, // 加群选项
    int maxMemberNum, // 最大群成员数
    bool visable, // 是否对外可见
    bool silenceAll, // 全员禁言
    Map<String, dynamic> customInfo, // 自定义信息
  }) async {
    return await _channel.invokeMethod('modifyGroupInfo', {
      "groupName": groupName,
      "groupId": groupId,
      "notification": notification,
      "introduction": introduction,
      "faceUrl": faceUrl,
      "addOption": addOption == null ? null : addOption.toString().replaceAll("AddGroupOptEnum.", ""),
      "maxMemberNum": maxMemberNum,
      "visable": visable,
      "silenceAll": silenceAll,
      "customInfo": customInfo == null ? null : jsonEncode(customInfo),
    });
  }

  /// 修改群成员资料
  static Future<void> modifyMemberInfo({
    @required String groupId, // 群ID
    @required String identifier, // 成员ID
    String nameCard, // 成员名片
    int silence, // 禁言时间
    int role, // 角色
    ReceiveMessageOptEnum receiveMessageOpt, // 接收消息选项
    Map<String, dynamic> customInfo, // 自定义信息
  }) async {
    return await _channel.invokeMethod('modifyMemberInfo', {
      "groupId": groupId,
      "identifier": identifier,
      "nameCard": nameCard,
      "silence": silence,
      "role": role,
      "customInfo": customInfo == null ? null : jsonEncode(customInfo),
      "receiveMessageOpt": receiveMessageOpt == null ? null : EnumUtil.getEnumName(receiveMessageOpt),
    });
  }

  /// 获得群未决列表
  static Future<GroupPendencyPageEntity> getGroupPendencyList({
    int timestamp, // 翻页时间戳
    int numPerPage, // 每页数量
  }) async {
    return GroupPendencyPageEntity.fromJson(jsonDecode(await _channel.invokeMethod('getGroupPendencyList', {
      "timestamp": timestamp,
      "numPerPage": numPerPage,
    })));
  }

  /// 上报未决已读
  static Future<void> reportGroupPendency({
    @required int timestamp, // 已读时间戳
  }) async {
    return await _channel.invokeMethod('reportGroupPendency', {
      "timestamp": timestamp,
    });
  }

  /// 未决同意申请
  /// 注意：请谨慎使用该接口，因为该接口会遍历所有未决申请来进行操作(根据 addTime、GroupId、identifier)来进行匹配
  static Future<void> groupPendencyAccept({
    @required int addTime, // 添加时间戳(对应列表中的addTime)
    @required String groupId, // 群ID
    @required String identifier, // 申请人ID
    String msg, //同意理由
  }) async {
    return await _channel.invokeMethod('groupPendencyAccept', {
      "addTime": addTime,
      "groupId": groupId,
      "identifier": identifier,
      "msg": msg,
    });
  }

  /// 未决拒绝申请
  /// 注意：请谨慎使用该接口，因为该接口会遍历所有未决申请来进行操作(根据 addTime、GroupId、identifier)来进行匹配
  static Future<void> groupPendencyRefuse({
    @required int addTime, // 添加时间戳(对应列表中的addTime)
    @required String groupId, // 群ID
    @required String identifier, // 申请人ID
    String msg, //同意理由
  }) async {
    return await _channel.invokeMethod('groupPendencyRefuse', {
      "addTime": addTime,
      "groupId": groupId,
      "identifier": identifier,
      "msg": msg,
    });
  }

  /// 获得自己的资料
  static Future<UserInfoEntity> getSelfProfile({
    bool forceUpdate: true, // 是否强制走服务器获取
  }) async {
    final String result = await _channel.invokeMethod('getSelfProfile', {"forceUpdate": forceUpdate});
    if (result != null) {
      return EntityFactory.generateOBJ<UserInfoEntity>(jsonDecode(result));
    }
    return null;
  }

  /// 获得用户信息
  /// @return 用户ID
  static Future<UserInfoEntity> getUserInfo({
    @required id,
    bool forceUpdate: false, // 是否强制走服务器获取
  }) async {
    final String result = await _channel.invokeMethod('getUserInfo', {
      "id": id,
      "forceUpdate": forceUpdate,
    });
    if (result != null) {
      return EntityFactory.generateOBJ<UserInfoEntity>(jsonDecode(result));
    }
    return null;
  }

  /// 修改自己的资料
  static Future<void> modifySelfProfile({
    @required Map<String, dynamic> params, // 参数，参见腾讯云修改自己资料文档 https://cloud.tencent.com/document/product/269/33926#.E4.BF.AE.E6.94.B9.E8.87.AA.E5.B7.B1.E7.9A.84.E8.B5.84.E6.96.99
  }) async {
    return await _channel.invokeMethod('modifySelfProfile', {
      "params": jsonEncode(params),
    });
  }

  /// 获得好友列表
  static Future<List<FriendEntity>> getFriendList() async {
    return ListUtil.generateOBJList<FriendEntity>(jsonDecode(await _channel.invokeMethod('getFriendList')));
  }

  /// 修改好友资料
  static Future<void> modifyFriend({
    @required String identifier, // 好友id
    @required Map<String, dynamic> params, // 参数，参见腾讯云修改自己资料文档 https://cloud.tencent.com/document/product/269/33926#.E4.BF.AE.E6.94.B9.E5.A5.BD.E5.8F.8B
  }) async {
    return await _channel.invokeMethod('modifyFriend', {
      "identifier": identifier,
      "params": jsonEncode(params),
    });
  }

  /// 添加好友
  static Future<AddFriendResultEntity> addFriend({
    @required String id,
    String remark,
    String addWording,
    String addSource,
    String friendGroup,
    @required FriendAddTypeEnum addType,
  }) async {
    String data = await _channel.invokeMethod('addFriend', {
      "id": id,
      "remark": remark,
      "addWording": addWording,
      "addSource": addSource,
      "friendGroup": friendGroup,
      "addType": addType == null ? null : FriendAddTypeTool.getIndexByEnum(addType),
    });
    return AddFriendResultEntity.fromJson(jsonDecode(data));
  }

  /// 删除好友
  static Future<List<dynamic>> deleteFriends({
    @required List<String> ids, // 好友列表
    @required int delFriendType, // 删除类型
  }) async {
    return jsonDecode(await _channel.invokeMethod('deleteFriends', {
      "ids": ids.join(","),
      "delFriendType": delFriendType,
    }));
  }

  /// 未决审核(通过/拒绝)(同意/拒绝好友申请)
  static Future<void> examinePendency({
    @required PendencyExamineTypeEnum type,
    @required String id,
    String remark,
  }) async {
    return await _channel.invokeMethod('examinePendency', {
      "id": id,
      "remark": remark ?? "",
      "type": PendencyExamineTypeEnumTool.getIndexByEnum(type),
    });
  }

  /// 校验好友关系
  static Future<CheckFriendResultEntity> checkSingleFriends({
    @required String id,
    @required FriendCheckTypeEnum type,
  }) async {
    String data = await _channel.invokeMethod('checkSingleFriends', {
      "id": id,
      "type": type == null ? null : FriendCheckTypeTool.getIndexByEnum(type),
    });
    return CheckFriendResultEntity.fromJson(jsonDecode(data));
  }

  /// 获得未决好友列表
  static Future<PendencyPageEntity> getPendencyList({
    int seq: 0,
    int timestamp: 0,
    int numPerPage: 0,
    @required PendencyTypeEnum type,
  }) async {
    String data = await _channel.invokeMethod('getPendencyList', {
      "type": PendencyTypeTool.getIndexByEnum(type),
      "seq": seq,
      "timestamp": timestamp,
      "numPerPage": numPerPage,
    });
    return EntityFactory.generateOBJ<PendencyPageEntity>(jsonDecode(data));
  }

  /// 设置未决已读
  static Future<void> pendencyReport({
    int timestamp: 0,
  }) async {
    return await _channel.invokeMethod('pendencyReport', {
      "timestamp": timestamp,
    });
  }

  /// 未决删除
  static Future<void> deletePendency({
    @required PendencyTypeEnum type,
    @required String id,
  }) async {
    return await _channel.invokeMethod('deletePendency', {
      "id": id,
      "type": PendencyTypeTool.getIndexByEnum(type),
    });
  }

  /// 添加到黑名单
  static Future<List<dynamic>> addBlackList({
    @required List<String> ids,
  }) async {
    return jsonDecode(await _channel.invokeMethod('addBlackList', {
      "ids": ids.join(","),
    }));
  }

  /// 从黑名单移除
  static Future<List<dynamic>> deleteBlackList({
    @required List<String> ids,
  }) async {
    return jsonDecode(await _channel.invokeMethod('deleteBlackList', {
      "ids": ids.join(","),
    }));
  }

  /// 获得黑名单列表
  static Future<List<FriendEntity>> getBlackList() async {
    return ListUtil.generateOBJList<FriendEntity>(jsonDecode(await _channel.invokeMethod('getBlackList')));
  }

  /// 创建好友分组
  static Future<List<dynamic>> createFriendGroup({
    @required List<String> groupNames,
    @required List<String> ids,
  }) async {
    return jsonDecode(await _channel.invokeMethod('createFriendGroup', {
      "groupNames": groupNames.join(","),
      "ids": ids.join(","),
    }));
  }

  /// 删除好友分组
  static Future<void> deleteFriendGroup({
    @required List<String> groupNames,
  }) async {
    return jsonDecode(await _channel.invokeMethod('deleteFriendGroup', {
      "groupNames": groupNames.join(","),
    }));
  }

  /// 添加好友到某个分组
  static Future<List<dynamic>> addFriendsToFriendGroup({
    @required List<String> ids,
    @required String groupName,
  }) async {
    return jsonDecode(await _channel.invokeMethod('addFriendsToFriendGroup', {
      "ids": ids.join(","),
      "groupName": groupName,
    }));
  }

  /// 从某个分组删除好友
  static Future<List<dynamic>> deleteFriendsFromFriendGroup({
    @required List<String> ids,
    @required String groupName,
  }) async {
    return jsonDecode(await _channel.invokeMethod('deleteFriendsFromFriendGroup', {
      "ids": ids.join(","),
      "groupName": groupName,
    }));
  }

  /// 重命名分组
  static Future<void> renameFriendGroup({
    @required String oldGroupName,
    @required String newGroupName,
  }) async {
    return jsonDecode(await _channel.invokeMethod('renameFriendGroup', {
      "oldGroupName": oldGroupName,
      "newGroupName": newGroupName,
    }));
  }

  /// 获得好友分组
  static Future<List<dynamic>> getFriendGroups({
    List<String> groupNames,
  }) async {
    return jsonDecode(await _channel.invokeMethod('getFriendGroups', {
      "groupNames": groupNames == null ? null : groupNames.join(","),
    }));
  }

  /// 撤回
  /// 注意：message 对象必须包含: sessionId、sessionType、rand、seq 属性
  static Future<void> revokeMessage({
    @required MessageEntity message, // 消息对象
  }) async {
    return await _channel.invokeMethod('revokeMessage', {
      "message": jsonEncode(message),
    });
  }

  /// 删除(仅会删除本地)
  /// 注意：message 对象必须包含: sessionId、sessionType、rand、seq 属性
  static Future<bool> removeMessage({
    @required MessageEntity message, // 消息对象
  }) async {
    return await _channel.invokeMethod('removeMessage', {
      "message": jsonEncode(message),
    });
  }

  /// 设置自定义整型
  /// 注意：message 对象必须包含: sessionId、sessionType、rand、seq 属性
  static Future<void> setMessageCustomInt({
    @required MessageEntity message, // 消息对象
    @required int value, // 会话ID
  }) async {
    return await _channel.invokeMethod('setMessageCustomInt', {
      "message": jsonEncode(message),
      "value": value,
    });
  }

  /// 设置自定义字符串
  /// 注意：message 对象必须包含: sessionId、sessionType、rand、seq 属性
  static Future<void> setMessageCustomStr({
    @required MessageEntity message, // 消息对象
    @required String value, // 会话ID
  }) async {
    return await _channel.invokeMethod('setMessageCustomStr', {
      "message": jsonEncode(message),
      "value": value,
    });
  }

  /// 获得视频图片
  /// 注意：message 对象必须包含: sessionId、sessionType、rand、seq 属性
  static Future<String> downloadVideoImage({
    @required MessageEntity message, // 消息对象
    String path, // 保存截图的路径
  }) async {
    return await _channel.invokeMethod('downloadVideoImage', {
      "message": jsonEncode(message),
      "path": path,
    });
  }

  /// 获得视频
  /// 注意：message 对象必须包含: sessionId、sessionType、rand、seq 属性
  static Future<String> downloadVideo({
    @required MessageEntity message, // 消息对象
    String path, // 保存视频的路径
  }) async {
    return await _channel.invokeMethod('downloadVideo', {
      "message": jsonEncode(message),
      "path": path,
    });
  }

  /// 查找消息对象
  static Future<MessageEntity> findMessage({
    @required sessionId,
    @required SessionType sessionType,
    @required int rand,
    @required int seq,
    int timestamp,
    bool self: true,
  }) async {
    String data = await _channel.invokeMethod('findMessage', {
      "message": jsonEncode({
        "sessionId": sessionId,
        "sessionType": EnumUtil.getEnumName(sessionType),
        "rand": rand,
        "seq": seq,
        "timestamp": timestamp,
        "self": self,
      }),
    });
    return data == null ? null : MessageEntity.fromJson(jsonDecode(data));
  }

  /// 获得语音
  /// 注意：message 对象必须包含: sessionId、sessionType、rand、seq 属性
  static Future<String> downloadSound({
    @required MessageEntity message, // 消息对象
    String path, // 保存语音的路径
  }) async {
    return await _channel.invokeMethod('downloadSound', {
      "message": jsonEncode(message),
      "path": path,
    });
  }

  /// 设置离线推送配置
  static Future<void> setOfflinePushSettings({
    bool enabled, // 是否启用
    String c2cSound, // C2C音频文件
    String groupSound, // Group音频文件
    String videoSound, // 视频邀请音频文件
  }) async {
    return await _channel.invokeMethod('setOfflinePushSettings', {
      "enabled": enabled,
      "c2cSound": c2cSound,
      "groupSound": groupSound,
      "videoSound": videoSound,
    });
  }

  /// 设置离线推送Token
  static Future<void> setOfflinePushToken({
    String token, // Token
    int bussid, // 推送证书 ID，是在 IM 控制台上生成的
  }) async {
    return await _channel.invokeMethod('setOfflinePushToken', {
      "token": token,
      "bussid": bussid,
    });
  }

  /// 添加消息监听
  static void addListener(ListenerValue func) {
    if (listener == null) {
      listener = TencentImPluginListener(_channel);
    }
    listener.addListener(func);
  }

  /// 移除消息监听
  static void removeListener(ListenerValue func) {
    if (listener == null) {
      listener = TencentImPluginListener(_channel);
    }
    listener.removeListener(func);
  }
}

/// 监听器对象
class TencentImPluginListener {
  /// 监听器列表
  static Set<ListenerValue> listeners = Set();

  TencentImPluginListener(MethodChannel channel) {
    // 绑定监听器
    channel.setMethodCallHandler((methodCall) async {
      // 解析参数
      Map<String, dynamic> arguments = jsonDecode(methodCall.arguments);

      switch (methodCall.method) {
        case 'onListener':
          // 获得原始类型和参数
          ListenerTypeEnum type = EnumUtil.nameOf(ListenerTypeEnum.values, arguments['type']);
          var paramsStr = arguments['params'];

          // 封装回调类型和参数
          var params;

          // 没有找到类型就返回
          if (type == null) {
            throw MissingPluginException();
          }

          // 根据类型初始化参数
          if (type == ListenerTypeEnum.NewMessages) {
            params = ListUtil.generateOBJList<MessageEntity>(jsonDecode(paramsStr));
          } else if (type == ListenerTypeEnum.RefreshConversation) {
            params = ListUtil.generateOBJList<SessionEntity>(jsonDecode(paramsStr));
          } else if (type == ListenerTypeEnum.RecvReceipt) {
            params = jsonDecode(paramsStr);
          } else {
            params = paramsStr;
          }

          // 回调触发
          for (var item in listeners) {
            item(type, params);
          }

          break;
        default:
          throw MissingPluginException();
      }
    });
  }

  /// 添加消息监听
  void addListener(ListenerValue func) {
    listeners.add(func);
  }

  /// 移除消息监听
  void removeListener(ListenerValue func) {
    listeners.remove(func);
  }
}

/// 监听器值模型
typedef ListenerValue<P> = void Function(ListenerTypeEnum type, P params);

/// 监听器类型枚举
enum ListenerTypeEnum {
  /// 被踢下线
  ForceOffline,

  /// 用户签名过期，需要重新登录
  UserSigExpired,

  /// 连接
  Connected,

  /// 断开连接
  Disconnected,

  /// Wifi需要认证【Android独享】
  WifiNeedAuth,

  /// 会话刷新
  Refresh,

  /// 会话刷新
  RefreshConversation,

  /// 消息撤回
  MessageRevoked,

  /// 新消息通知
  NewMessages,

  /// 群消息
  GroupTips,

  /// 已读(参数是已读会话ID集合)
  RecvReceipt,

  /// 断线重连失败【IOS独享】
  ReConnFailed,

  /// 网络连接失败【IOS独享】
  ConnFailed,

  /// 连接中【IOS独享】
  Connecting,

  /// 上传进度(图片、视频、语音等都会调用)
  UploadProgress,

  /// 下载进度(图片、视频、语音等)
  DownloadProgress,
}
