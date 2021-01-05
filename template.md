功能模块划分：

| 功能模块        | 是否完成 |
|:---------------|:--------|
| 初始化登录接口   | √       |
| 信令接口        | √       |
| 消息收发接口    | √       |
| 群组相关接口    | √       |
| 会话列表相关接口 | √       |
| 用户资料相关接口 | √       |
| 离线推送相关接口 | √       |
| 好友管理相关接口 | √       |


具体接口划分：

| 接口名称                                                                                         | 接口描述                                                                       |
|:------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------|
| [initSDK](https://www.yuque.com/jiangjuhong/tencent-im-flutter/dgoz8g)                          | 初始化SDK                                                                     |
| [unInitSDK](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ba3xc4)                        | 反初始化SDK                                                                    |
| [login](https://www.yuque.com/jiangjuhong/tencent-im-flutter/wpcivd)                            | 登录                                                                          |
| [logout](https://www.yuque.com/jiangjuhong/tencent-im-flutter/pngtrp)                           | 登出                                                                          |
| [getLoginStatus](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ibx4fz)                   | 获取登录状态                                                                   |
| [getLoginUser](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ba12bq)                     | 获得当前登录用户的UserId                                                        |
| [invite](https://www.yuque.com/jiangjuhong/tencent-im-flutter/wfmnxa)                           | 邀请某个人                                                                     |
| [inviteInGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/apvk3r)                    | 邀请群内某些人                                                                 |
| [cancel](https://www.yuque.com/jiangjuhong/tencent-im-flutter/rul9zz)                           | 邀请方取消邀请                                                                 |
| [accept](https://www.yuque.com/jiangjuhong/tencent-im-flutter/izqr2w)                           | 接收方接收邀请                                                                 |
| [reject](https://www.yuque.com/jiangjuhong/tencent-im-flutter/peyqzg)                           | 接收方拒绝邀请                                                                 |
| [getSignalingInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/tqezf5)                 | 获取信令信息                                                                   |
| [addInvitedSignaling](https://www.yuque.com/jiangjuhong/tencent-im-flutter/pbcnge)              | 添加邀请信令（可以用于群离线推送消息触发的邀请信令）                                |
| [sendMessage](https://www.yuque.com/jiangjuhong/tencent-im-flutter/iwzxm0)                      | 发送消息                                                                       |
| [resendMessage](https://www.yuque.com/jiangjuhong/tencent-im-flutter/mg5k6b)                    | 重新发送消息                                                                   |
| [revokeMessage](https://www.yuque.com/jiangjuhong/tencent-im-flutter/cmzefm)                    | 撤回消息                                                                       |
| [getHistoryMessageList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/pldzb9)            | 获得历史记录，此为 getC2CHistoryMessageList 和 getGroupHistoryMessageList 的封装 |
| [getC2CHistoryMessageList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/zsgx99)         | 获取单聊历史消息                                                                |
| [getGroupHistoryMessageList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/uo6i99)       | 获取群组历史消息                                                                |
| [markMessageAsRead](https://www.yuque.com/jiangjuhong/tencent-im-flutter/potth4)                | 设置聊天记录为已读，此为 markC2CMessageAsRead 和 markGroupMessageAsRead 的封装    |
| [markC2CMessageAsRead](https://www.yuque.com/jiangjuhong/tencent-im-flutter/oiic2d)             | 设置单聊已读                                                                   |
| [markGroupMessageAsRead](https://www.yuque.com/jiangjuhong/tencent-im-flutter/twt8oh)           | 设置群聊已读                                                                   |
| [deleteMessageFromLocalStorage](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ir00xv)    | 删除本地消息                                                                   |
| [deleteMessages](https://www.yuque.com/jiangjuhong/tencent-im-flutter/wu3m16)                   | 删除本地及漫游消息                                                              |
| [insertGroupMessageToLocalStorage](https://www.yuque.com/jiangjuhong/tencent-im-flutter/gx2vx5) | 向群组消息列表中添加一条消息                                                     |
| [downloadVideo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/mqdwgy)                    | 下载视频                                                                       |
| [downloadVideoThumbnail](https://www.yuque.com/jiangjuhong/tencent-im-flutter/zr1thy)           | 下载视频缩略图                                                                 |
| [downloadSound](https://www.yuque.com/jiangjuhong/tencent-im-flutter/exa4g6)                    | 下载语音                                                                       |
| [setMessageLocalCustomStr](https://www.yuque.com/jiangjuhong/tencent-im-flutter/muz7ae)         | 设置消息本地Str                                                                |
| [setMessageLocalCustomInt](https://www.yuque.com/jiangjuhong/tencent-im-flutter/od5caz)         | 设置消息本地Int                                                                |
| [createGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/xza7ly)                      | 创建群                                                                        |
| [joinGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ckchss)                        | 加入群                                                                        |
| [quitGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/rd1gpv)                        | 退出群                                                                        |
| [dismissGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/fv04e8)                     | 解散群                                                                        |
| [getJoinedGroupList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/fke2t2)               | 获取已经加入的群列表（不包括已加入的直播群）                                       |
| [getGroupsInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/zxca6v)                    | 拉取群资料                                                                     |
| [setGroupInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/kasna1)                     | 修改群资料                                                                     |
| [setReceiveMessageOpt](https://www.yuque.com/jiangjuhong/tencent-im-flutter/cqt0sy)             | 设置群消息接收选项                                                              |
| [initGroupAttributes](https://www.yuque.com/jiangjuhong/tencent-im-flutter/nn8y59)              | 初始化群属性，会清空原有的群属性列表                                              |
| [setGroupAttributes](https://www.yuque.com/jiangjuhong/tencent-im-flutter/hgerzs)               | 设置群属性。已有该群属性则更新其 value 值，没有该群属性则添加该属性。                |
| [deleteGroupAttributes](https://www.yuque.com/jiangjuhong/tencent-im-flutter/xzsnk0)            | 删除指定群属性，keys 传 null 则清空所有群属性。。                                 |
| [getGroupAttributes](https://www.yuque.com/jiangjuhong/tencent-im-flutter/xiayku)               | 获取指定群属性，keys 传 null 则获取所有群属性。                                   |
| [getGroupOnlineMemberCount](https://www.yuque.com/jiangjuhong/tencent-im-flutter/wmvq1m)        | 获取指定群在线人数                                                              |
| [getGroupMemberList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/zhpfm8)               | 获得群成员列表                                                                 |
| [getGroupMembersInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/yap9xi)              | 获取指定的群成员资料                                                            |
| [setGroupMemberInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/nhfds4)               | 修改指定的群成员资料                                                            |
| [muteGroupMember](https://www.yuque.com/jiangjuhong/tencent-im-flutter/taeqlm)                  | 禁言（只有管理员或群主能够调用）                                                  |
| [inviteUserToGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/pz4w53)                | 邀请他人入群                                                                   |
| [kickGroupMember](https://www.yuque.com/jiangjuhong/tencent-im-flutter/icgl2p)                  | 踢人                                                                          |
| [setGroupMemberRole](https://www.yuque.com/jiangjuhong/tencent-im-flutter/htf9ez)               | 切换群成员角色                                                                 |
| [transferGroupOwner](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ugfzyr)               | 转让群主                                                                       |
| [getGroupApplicationList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/nf7ggd)          | 获取加群申请列表                                                                |
| [acceptGroupApplication](https://www.yuque.com/jiangjuhong/tencent-im-flutter/lefqco)           | 同意某一条加群申请                                                              |
| [refuseGroupApplication](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ahv1yk)           | 拒绝某一条加群申请                                                              |
| [setGroupApplicationRead](https://www.yuque.com/jiangjuhong/tencent-im-flutter/uro3xg)          | 标记申请列表为已读                                                              |
| [getConversationList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/nxb35a)              | 获得会话列表                                                                   |
| [getConversation](https://www.yuque.com/jiangjuhong/tencent-im-flutter/zxm7b9)                  | 获得指定会话                                                                   |
| [deleteConversation](https://www.yuque.com/jiangjuhong/tencent-im-flutter/zdqqgr)               | 删除会话                                                                       |
| [setConversationDraft](https://www.yuque.com/jiangjuhong/tencent-im-flutter/gwgxib)             | 设置会话草稿                                                                   |
| [getUsersInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/cpe5cf)                     | 获取用户资料                                                                   |
| [setSelfInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ig7hio)                      | 修改个人资料                                                                   |
| [addToBlackList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/pypa2v)                   | 添加用户到黑名单                                                                |
| [deleteFromBlackList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/plpnd3)              | 从黑名单中删除                                                                 |
| [getBlackList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/tku7ti)                     | 获得黑名单列表                                                                 |
| [setOfflinePushConfig](https://www.yuque.com/jiangjuhong/tencent-im-flutter/mz8puv)             | 设置离线推送配置                                                                |
| [setUnreadBadge](https://www.yuque.com/jiangjuhong/tencent-im-flutter/gxrg7g)                   | 设置未读桌标                                                                   |
| [getFriendList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/fbp9mm)                    | 获取好友列表                                                                   |
| [getFriendsInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/flu3rw)                   | 获取指定好友信息                                                                |
| [setFriendInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/sdf83g)                    | 设置好友资料                                                                   |
| [addFriend](https://www.yuque.com/jiangjuhong/tencent-im-flutter/vmgd6b)                        | 添加好友                                                                       |
| [deleteFromFriendList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/iw1qu0)             | 删除好友                                                                       |
| [checkFriend](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ids5fn)                      | 检查指定用户的好友关系                                                          |
| [getFriendApplicationList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/cssknz)         | 获取好友申请列表                                                                |
| [acceptFriendApplication](https://www.yuque.com/jiangjuhong/tencent-im-flutter/vg899d)          | 同意好友申请                                                                   |
| [refuseFriendApplication](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ugyw9h)          | 拒绝好友申请                                                                   |
| [deleteFriendApplication](https://www.yuque.com/jiangjuhong/tencent-im-flutter/tc1o1n)          | 删除好友申请                                                                   |
| [setFriendApplicationRead](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ln3h8m)         | 设置好友申请为已读                                                              |
| [createFriendGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/kg0r1p)                | 新建好友分组                                                                   |
| [getFriendGroups](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ecgpbb)                  | 获得分组信息                                                                   |
| [deleteFriendGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/di8fy1)                | 删除好友分组                                                                   |
| [renameFriendGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/gtrzn7)                | 修改好友分组名称                                                                |
| [addFriendsToFriendGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/rpoulh)          | 添加好友到分组                                                                 |
| [deleteFriendsFromFriendGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ex5kpm)     | 从分组中删除好友                                                                |


> 设置消息本地Int

| 参数名称 | 参数描述    | 参数类型           |
|:--------|:-----------|:------------------|
| message | 查找消息对象 | FindMessageEntity |
| data    | 数据对象    | int               |

**使用：**

```dart
TencentRtcPlugin.setMessageLocalCustomInt(
  message: FindMessageEntity(msgID:'123'),
  data:1,
);
```


# 回调事件

| 回调名称                      | 回调描述                        | 回调参数类型                       | 支持平台      |
|:-----------------------------|:-------------------------------|:----------------------------------|:-------------|
| NewMessage                   | 新消息监听                      | MessageEntity                     | Android、IOS |
| C2CReadReceipt               | C2C已读回执                     | MessageReceiptEntity              | Android、IOS |
| MessageRevoked               | 消息撤回                        | String（消息ID）                   | Android、IOS |
| SyncServerStart              | 同步服务开始                    | -                                 | Android、IOS |
| SyncServerFinish             | 同步服务完成                    | -                                 | Android、IOS |
| SyncServerFailed             | 同步服务失败                    | -                                 | Android、IOS |
| NewConversation              | 新会话                          | List\<ConversationEntity>         | Android、IOS |
| ConversationChanged          | 会话刷新                        | List\<ConversationEntity>         | Android、IOS |
| FriendApplicationListAdded   | 好友申请新增                    | List\<FriendApplicationEntity>    | Android、IOS |
| FriendApplicationListDeleted | 好友申请删除                    | List\<String>（用户ID列表）         | Android、IOS |
| FriendApplicationListRead    | 好友申请已读                    | -                                 | Android、IOS |
| FriendListAdded              | 好友新增                        | List\<FriendInfoEntity>           | Android、IOS |
| FriendListDeleted            | 好友删除                        | List\<String>（用户ID列表）        | Android、IOS |
| BlackListAdd                 | 黑名单新增                      | List\<FriendInfoEntity>           | Android、IOS |
| BlackListDeleted             | 黑名单删除                      | List\<String>（用户ID列表）         | Android、IOS |
| FriendInfoChanged            | 好友资料更新                    | List\<FriendInfoEntity>           | Android、IOS |
| MemberEnter                  | 用户加入群                      | GroupMemberEnterEntity            | Android、IOS |
| MemberLeave                  | 用户离开群                      | GroupMemberLeaveEntity            | Android、IOS |
| MemberInvited                | 用户被拉入群                    | GroupMemberInvitedOrKickedEntity  | Android、IOS |
| MemberKicked                 | 用户被踢出群                    | GroupMemberInvitedOrKickedEntity  | Android、IOS |
| MemberInfoChanged            | 群成员信息被修改                 | GroupMemberChangedEntity          | Android、IOS |
| GroupCreated                 | 创建群                          | String（群ID）                    | Android、IOS |
| GroupDismissed               | 群被解散                        | GroupDismissedOrRecycledEntity    | Android、IOS |
| GroupRecycled                | 群被回收                        | GroupDismissedOrRecycledEntity    | Android、IOS |
| GroupInfoChanged             | 群信息被修改                    | GroupChangedEntity                | Android、IOS |
| ReceiveJoinApplication       | 有新的加群申请                   | GroupReceiveJoinApplicationEntity | Android、IOS |
| ApplicationProcessed         | 加群信息已被管理员处理            | GroupApplicationProcessedEntity   | Android、IOS |
| GrantAdministrator           | 指定管理员身份                   | GroupAdministratorOpEntity        | Android、IOS |
| RevokeAdministrator          | 取消管理员身份                   | GroupAdministratorOpEntity        | Android、IOS |
| QuitFromGroup                | 主动退出群组                    | String（群ID）                     | Android、IOS |
| ReceiveRESTCustomData        | 收到 RESTAPI 下发的自定义系统消息 | GroupReceiveRESTEntity            | Android、IOS |
| GroupAttributeChanged        | 群属性更新                      | GroupAttributeChangedEntity       | Android、IOS |
| Connecting                   | 正在连接腾讯云服务器             | -                                 | Android、IOS |
| ConnectSuccess               | 网络连接成功                    | -                                 | Android、IOS |
| ConnectFailed                | 网络连接失败                    | ErrorEntity                       | Android、IOS |
| KickedOffline                | 被踢下线                        | -                                 | Android、IOS |
| SelfInfoUpdated              | 当前用户资料更新                 | UserEntity                        | Android、IOS |
| UserSigExpired               | 用户登录签名过期                 | -                                 | Android、IOS |
| ReceiveNewInvitation         | 收到信令邀请                    | SignalingCommonEntity             | Android、IOS |
| InviteeAccepted              | 信令被邀请者接受邀请             | SignalingCommonEntity             | Android、IOS |
| InviteeRejected              | 信令被邀请者拒绝邀请             | SignalingCommonEntity             | Android、IOS |
| InvitationCancelled          | 信令邀请被取消                   | SignalingCommonEntity             | Android、IOS |
| InvitationTimeout            | 信令邀请超时                    | SignalingCommonEntity             | Android、IOS |
| DownloadProgress             | 下载进度                        | DownloadProgressEntity            | Android、IOS |
| MessageSendSucc              | 消息发送成功                    | MessageEntity                     | Android、IOS |
| MessageSendFail              | 消息发送失败                    | MessageSendFailEntity             | Android、IOS |
| MessageSendFail              | 消息发送进度更新                 | MessageSendProgressEntity         | Android、IOS |

**回调监听示例：**

```dart
TencentImPlugin.addListener((type, param) {
  if (type == TencentImListenerTypeEnum.EnterRoom) {

  } else if ...
});
```


