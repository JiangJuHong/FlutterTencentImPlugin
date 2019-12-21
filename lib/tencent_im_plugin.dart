import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:tencent_im_plugin/base64_util.dart';
import 'package:tencent_im_plugin/entity/add_friend_result_entity.dart';
import 'package:tencent_im_plugin/entity/check_friend_result_entity.dart';
import 'package:tencent_im_plugin/entity/group_pendency_page_entity.dart';
import 'package:tencent_im_plugin/entity_factory.dart';
import 'package:tencent_im_plugin/enums/add_group_opt_enum.dart';
import 'package:tencent_im_plugin/list_util.dart';

import 'entity/friend_entity.dart';
import 'entity/group_info_entity.dart';
import 'entity/group_member_entity.dart';
import 'entity/message_entity.dart';
import 'entity/pendency_page_entity.dart';
import 'entity/session_entity.dart';
import 'entity/user_info_entity.dart';
import 'enums/friend_add_type_enum.dart';
import 'enums/friend_check_type_enum.dart';
import 'enums/pendency_examine_type_enum.dart';
import 'enums/pendency_type_enum.dart';
import 'enums/receive_message_opt_enum.dart';

class TencentImPlugin {
  static const MethodChannel _channel =
      const MethodChannel('tencent_im_plugin');

  /// 监听器对象
  static TencentImPluginListener listener;

  /// 初始化腾讯云IM插件
  static Future<void> init({@required String appid}) async {
    await _channel.invokeMethod('init', {"appid": appid});
  }

  /// 登录腾讯云IM
  static Future<void> login({
    @required String identifier, // 用户ID
    @required String userSig, // 用户签名
  }) async {
    return await _channel
        .invokeMethod('login', {"identifier": identifier, "userSig": userSig});
  }

  /// 初始化本地存储，可以在无网络情况下加载本地会话和消息
  static Future<void> initStorage({
    @required String identifier, // 登录用户ID
  }) async {
    return await _channel
        .invokeMethod('initStorage', {"identifier": identifier});
  }

  /// 退出登录腾讯云IM
  static Future<void> logout() async {
    return await _channel.invokeMethod('logout');
  }

  /// 获得当前登录用户
  /// @return 登录用户ID
  static Future<String> getLoginUser() async {
    return await _channel.invokeMethod('getLoginUser');
  }

  /// 发送文本消息
  static Future<MessageEntity> sendTextMessage({
    @required String sessionId, // 会话ID
    @required SessionType sessionType, // 会话类型
    @required String content, //发送内容
    bool ol: false, // 是否为在线消息，如果为true，将使用 sendOnlineMessage 通道进行消息发送
  }) async {
    final String result = await _channel.invokeMethod('sendTextMessage', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "content": content,
      "ol": ol,
    });

    if (result != null) {
      return EntityFactory.generateOBJ<MessageEntity>(jsonDecode(result));
    }
    return null;
  }

  /// 发送图片消息
  static Future<MessageEntity> sendImageMessage({
    @required String sessionId, // 会话ID
    @required SessionType sessionType, // 会话类型
    @required String path, // 发送图片路径
    bool ol: false, // 是否为在线消息，如果为true，将使用 sendOnlineMessage 通道进行消息发送
  }) async {
    final String result = await _channel.invokeMethod('sendImageMessage', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "path": path,
      "ol": ol,
    });

    if (result != null) {
      return EntityFactory.generateOBJ<MessageEntity>(jsonDecode(result));
    }
    return null;
  }

  /// 发送语音消息
  static Future<MessageEntity> sendSoundMessage({
    @required String sessionId, // 会话ID
    @required SessionType sessionType, // 会话类型
    @required String path, // 语音路径
    @required int duration, // 语音时长
    bool ol: false, // 是否为在线消息，如果为true，将使用 sendOnlineMessage 通道进行消息发送
  }) async {
    final String result = await _channel.invokeMethod('sendSoundMessage', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "path": path,
      "duration": duration,
      "ol": ol,
    });

    if (result != null) {
      return EntityFactory.generateOBJ<MessageEntity>(jsonDecode(result));
    }
    return null;
  }

  /// 发送自定义消息
  static Future<MessageEntity> sendCustomMessage({
    @required String sessionId, // 会话ID
    @required SessionType sessionType, // 会话类型
    @required String data, // 自定义消息数据
    String ext,
    String sound,
    String desc,
    bool ol: false, // 是否为在线消息，如果为true，将使用 sendOnlineMessage 通道进行消息发送
  }) async {
    final String result = await _channel.invokeMethod('sendCustomMessage', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "data": data,
      "ext": ext,
      "sound": sound,
      "desc": desc,
      "ol": ol,
    });

    if (result != null) {
      return EntityFactory.generateOBJ<MessageEntity>(jsonDecode(result));
    }
    return null;
  }

  /// 发送视频消息
  static Future<MessageEntity> sendVideoMessage({
    @required String sessionId, // 会话ID
    @required SessionType sessionType, // 会话类型
    @required String path, // 视频路径
    @required String type, // 视频类型
    @required int duration, // 视频时长
    @required int snapshotWidth, // 缩略图宽度
    @required int snapshotHeight, // 缩略图高度
    @required String snapshotPath, // 缩略图路径
    bool ol: false, // 是否为在线消息，如果为true，将使用 sendOnlineMessage 通道进行消息发送
  }) async {
    final String result = await _channel.invokeMethod('sendVideoMessage', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "path": path,
      "type": type,
      "duration": duration,
      "snapshotWidth": snapshotWidth,
      "snapshotHeight": snapshotHeight,
      "snapshotPath": snapshotPath,
      "ol": ol,
    });

    if (result != null) {
      return EntityFactory.generateOBJ<MessageEntity>(jsonDecode(result));
    }
    return null;
  }

  /// 获得当前登录用户会话列表
  /// @return 会话列表集合
  static Future<List<SessionEntity>> getConversationList() async {
    return ListUtil.generateOBJList<SessionEntity>(
        jsonDecode(await _channel.invokeMethod('getConversationList')));
  }

  /// 根据会话ID获得本地消息列表
  /// @param sessionId 会话ID
  /// @param sessionType 会话类型
  /// @param number 拉取消息数量
  /// @return 消息列表集合
  static Future<List<MessageEntity>> getLocalMessages({
    @required String sessionId,
    @required SessionType sessionType,
    @required int number,
  }) async {
    return ListUtil.generateOBJList<MessageEntity>(
        jsonDecode(await _channel.invokeMethod('getLocalMessages', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "number": number,
    })));
  }

  /// 根据会话ID获得消息列表
  /// @param sessionId 会话ID
  /// @param sessionType 会话类型
  /// @param number 拉取消息数量
  /// @return 消息列表集合
  static Future<List<MessageEntity>> getMessages({
    @required String sessionId,
    @required SessionType sessionType,
    @required int number,
  }) async {
    return ListUtil.generateOBJList<MessageEntity>(
        jsonDecode(await _channel.invokeMethod('getMessages', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
      "number": number,
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
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
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
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
    });
  }

  /// 设置会话消息为已读
  static Future<void> setRead({
    @required String sessionId,
    @required SessionType sessionType,
  }) async {
    return await _channel.invokeMethod('setRead', {
      "sessionId": sessionId,
      "sessionType": sessionType.toString().replaceFirst("SessionType.", ""),
    });
  }

  /// 创建群聊
  static Future<String> createGroup({
    @required
        String
            type, // 群类型，参考腾讯云IM文档，``目前支持的群类型：私有群（Private）、公开群（Public）、 聊天室（ChatRoom）、互动直播聊天室（AVChatRoom）和在线成员广播大群（BChatRoom）``
    @required String name, // 群名称
    String groupId, //群ID
    String notification, //群公告
    String introduction, // 群简介
    String faceUrl, // 群头像
    AddGroupOptEnum addOption, // 加群选项
    int maxMemberNum, // 最大群成员数
  }) async {
    return await _channel.invokeMethod('createGroup', {
      "type": type,
      "name": name,
      "groupId": groupId,
      "notification": notification,
      "introduction": introduction,
      "faceUrl": faceUrl,
      "addOption": addOption.toString().replaceAll("AddGroupOptEnum.", ""),
      "maxMemberNum": maxMemberNum,
    });
  }

  /// 邀请用户加入群组
  static Future<List<dynamic>> inviteGroupMember({
    @required String groupId, //群ID
    @required List<String> ids, // 用户I集合
  }) async {
    return jsonDecode(await _channel.invokeMethod('inviteGroupMember', {
      "groupId": groupId,
      "ids": jsonEncode(ids),
    }));
  }

  /// 申请加入群组
  static Future<void> applyJoinGroup({
    @required String groupId, //群ID
    String reason, //申请理由
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
      "ids": jsonEncode(ids),
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
    return ListUtil.generateOBJList<GroupMemberEntity>(
        jsonDecode(await _channel.invokeMethod('getGroupMembers', {
      "groupId": groupId,
    })));
  }

  /// 获得群列表
  static Future<List<GroupInfoEntity>> getGroupList() async {
    return ListUtil.generateOBJList<GroupInfoEntity>(
        jsonDecode(await _channel.invokeMethod('getGroupList')));
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
    final String result =
        await _channel.invokeMethod('getGroupInfo', {"id": id});
    if (result != null) {
      GroupInfoEntity groupInfoEntity =  EntityFactory.generateOBJ<GroupInfoEntity>(jsonDecode(result));
      if(groupInfoEntity != null && groupInfoEntity.custom != null && groupInfoEntity.custom.length != 0){
        for(var key in groupInfoEntity.custom.keys){
          groupInfoEntity.custom[key] = Base64Util.base64Decode(groupInfoEntity.custom[key]);
        }
      }
    }
    return null;
  }

  /// 修改群资料
  static Future<void> modifyGroupInfo({
    String name, // 群名称
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
      "name": name,
      "groupId": groupId,
      "notification": notification,
      "introduction": introduction,
      "faceUrl": faceUrl,
      "addOption": addOption == null
          ? null
          : addOption.toString().replaceAll("AddGroupOptEnum.", ""),
      "maxMemberNum": maxMemberNum,
      "visable": visable,
      "silenceAll": silenceAll,
      "customInfo": customInfo == null ? null : jsonEncode(customInfo),
    });
  }

  /// 修改群成员资料
  static Future<void> modifyMemberInfo({
    @required String name, // 群名称
    @required String identifier, // 成员ID
    String nameCard, // 成员名片
    int silence, // 禁言时间
    int role, // 角色
    ReceiveMessageOptEnum receiveMessageOpt, // 接收消息选项
  }) async {
    return await _channel.invokeMethod('modifyMemberInfo', {
      "name": name,
      "identifier": identifier,
      "nameCard": nameCard,
      "silence": silence,
      "role": role,
      "receiveMessageOpt": receiveMessageOpt == null
          ? null
          : receiveMessageOpt
              .toString()
              .replaceAll("ReceiveMessageOptEnum.", ""),
    });
  }

  /// 获得群未决列表
  static Future<GroupPendencyPageEntity> getGroupPendencyList({
    int timestamp, // 翻页时间戳
    int numPerPage, // 每页数量
  }) async {
    return GroupPendencyPageEntity.fromJson(
        jsonDecode(await _channel.invokeMethod('getGroupPendencyList', {
      "timestamp": timestamp,
      "numPerPage": numPerPage,
    })));
  }

  /// 上报未决已读
  static Future<void> reportGroupPendency({
    int timestamp, // 已读时间戳
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
    final String result = await _channel
        .invokeMethod('getSelfProfile', {"forceUpdate": forceUpdate});
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
    @required
        Map<String, dynamic>
            params, // 参数，参见腾讯云修改自己资料文档 https://cloud.tencent.com/document/product/269/33926#.E4.BF.AE.E6.94.B9.E8.87.AA.E5.B7.B1.E7.9A.84.E8.B5.84.E6.96.99
  }) async {
    return await _channel.invokeMethod('modifySelfProfile', {
      "params": jsonEncode(params),
    });
  }

  /// 获得好友列表
  static Future<List<FriendEntity>> getFriendList() async {
    return ListUtil.generateOBJList<FriendEntity>(
        jsonDecode(await _channel.invokeMethod('getFriendList')));
  }

  /// 修改好友资料
  static Future<void> modifyFriend({
    @required String identifier, // 好友id
    @required
        Map<String, dynamic>
            params, // 参数，参见腾讯云修改自己资料文档 https://cloud.tencent.com/document/product/269/33926#.E4.BF.AE.E6.94.B9.E5.A5.BD.E5.8F.8B
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
      "addType":
          addType == null ? null : FriendAddTypeTool.getIndexByEnum(addType),
    });
    return AddFriendResultEntity.fromJson(jsonDecode(data));
  }

  /// 删除好友
  static Future<Map> deleteFriends({
    @required List<String> ids, // 好友列表
    @required int delFriendType, // 删除类型
  }) async {
    return jsonDecode(await _channel.invokeMethod('deleteFriends', {
      "ids": jsonEncode(ids),
      "delFriendType": delFriendType,
    }));
  }

  /// 未决审核(通过/拒绝)(同意/拒绝好友申请)
  static Future<void> examinePendency({
    @required PendencyExamineTypeEnum type,
    @required String id,
    String remark,
  }) async {
    await _channel.invokeMethod('examinePendency', {
      "id": id,
      "remark": remark,
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
      "ids": jsonEncode(ids),
    }));
  }

  /// 从黑名单移除
  static Future<List<dynamic>> deleteBlackList({
    @required List<String> ids,
  }) async {
    return jsonDecode(await _channel.invokeMethod('deleteBlackList', {
      "ids": jsonEncode(ids),
    }));
  }

  /// 获得黑名单列表
  static Future<List<FriendEntity>> getBlackList() async {
    return ListUtil.generateOBJList<FriendEntity>(
        jsonDecode(await _channel.invokeMethod('getBlackList')));
  }

  /// 创建好友分组
  static Future<List<dynamic>> createFriendGroup({
    @required List<String> groupNames,
    @required List<String> ids,
  }) async {
    return jsonDecode(await _channel.invokeMethod('createFriendGroup', {
      "groupNames": jsonEncode(groupNames),
      "ids": jsonEncode(ids),
    }));
  }

  /// 删除好友分组
  static Future<void> deleteFriendGroup({
    @required List<String> groupNames,
  }) async {
    return jsonDecode(await _channel.invokeMethod('deleteFriendGroup', {
      "groupNames": jsonEncode(groupNames),
    }));
  }

  /// 添加好友到某个分组
  static Future<List<dynamic>> addFriendsToFriendGroup({
    @required List<String> ids,
    @required String groupName,
  }) async {
    return jsonDecode(await _channel.invokeMethod('addFriendsToFriendGroup', {
      "ids": jsonEncode(ids),
      "groupName": groupName,
    }));
  }

  /// 从某个分组删除好友
  static Future<void> deleteFriendsFromFriendGroup({
    @required List<String> ids,
    @required String groupName,
  }) async {
    return jsonDecode(
        await _channel.invokeMethod('deleteFriendsFromFriendGroup', {
      "ids": jsonEncode(ids),
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
  static Future<void> getFriendGroups({
    List<String> groupNames,
  }) async {
    return jsonDecode(await _channel.invokeMethod('getFriendGroups', {
      "groupNames": groupNames == null ? null : jsonEncode(groupNames),
    }));
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
          String typeStr = arguments['type'];
          String paramsStr = arguments['params'];

          // 封装回调类型和参数
          ListenerTypeEnum type;
          Object params;

          // 初始化类型
          for (var item in ListenerTypeEnum.values) {
            if (item.toString().replaceFirst("ListenerTypeEnum.", "") ==
                typeStr) {
              type = item;
              break;
            }
          }

          // 没有找到类型就返回
          if (type == null) {
            throw MissingPluginException();
          }

          // 根据类型初始化参数
          if (type == ListenerTypeEnum.NewMessages) {
            params =
                ListUtil.generateOBJList<MessageEntity>(jsonDecode(paramsStr));
          } else if (type == ListenerTypeEnum.RefreshConversation) {
            params =
                ListUtil.generateOBJList<SessionEntity>(jsonDecode(paramsStr));
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

  /// Wifi需要认证
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

  /// 下载开始
  DownloadStart,

  /// 下载成功
  DownloadSuccess,

  /// 下载失败
  DownloadFail,

  /// 已读(参数是已读会话ID集合)
  RecvReceipt,
}
