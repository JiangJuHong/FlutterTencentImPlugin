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

| 接口名称                                                                                         | 接口描述                                                       |
|:------------------------------------------------------------------------------------------------|:--------------------------------------------------------------|
| [initSDK](https://www.yuque.com/jiangjuhong/tencent-im-flutter/dgoz8g)                          | 初始化SDK                                                      |
| [unInitSDK](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ba3xc4)                        | 反初始化SDK                                                    |
| [login](https://www.yuque.com/jiangjuhong/tencent-im-flutter/wpcivd)                            | 登录                                                           |
| [logout](https://www.yuque.com/jiangjuhong/tencent-im-flutter/pngtrp)                           | 登出                                                           |
| [getLoginStatus](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ibx4fz)                   | 获取登录状态                                                    |
| [getLoginUser](https://www.yuque.com/jiangjuhong/tencent-im-flutter/ba12bq)                     | 获得当前登录用户的UserId                                        |
| [invite](https://www.yuque.com/jiangjuhong/tencent-im-flutter/wfmnxa)                           | 邀请某个人                                                     |
| [inviteInGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/apvk3r)                    | 邀请群内某些人                                                  |
| [cancel](https://www.yuque.com/jiangjuhong/tencent-im-flutter/rul9zz)                           | 邀请方取消邀请                                                  |
| [accept](https://www.yuque.com/jiangjuhong/tencent-im-flutter/izqr2w)                           | 接收方接收邀请                                                  |
| [reject](https://www.yuque.com/jiangjuhong/tencent-im-flutter/peyqzg)                           | 接收方拒绝邀请                                                  |
| [getSignalingInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/tqezf5)                 | 获取信令信息                                                    |
| [addInvitedSignaling](https://www.yuque.com/jiangjuhong/tencent-im-flutter/pbcnge)              | 添加邀请信令（可以用于群离线推送消息触发的邀请信令）                 |
| [sendMessage](https://www.yuque.com/jiangjuhong/tencent-im-flutter/iwzxm0)                      | 发送消息                                                       |
| [revokeMessage](https://www.yuque.com/jiangjuhong/tencent-im-flutter/cmzefm)                    | 撤回消息                                                       |
| [getC2CHistoryMessageList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/zsgx99)         | 获取单聊历史消息                                                |
| [getGroupHistoryMessageList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/uo6i99)       | 获取群组历史消息                                                |
| [markC2CMessageAsRead](https://www.yuque.com/jiangjuhong/tencent-im-flutter/oiic2d)             | 设置单聊已读                                                    |
| [markGroupMessageAsRead](https://www.yuque.com/jiangjuhong/tencent-im-flutter/twt8oh)           | 设置群聊已读                                                    |
| [deleteMessageFromLocalStorage](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)          | 删除本地消息                                                    |
| [deleteMessages](https://www.yuque.com/jiangjuhong/tencent-im-flutter/wu3m16)                   | 删除本地及漫游消息                                              |
| [insertGroupMessageToLocalStorage](https://www.yuque.com/jiangjuhong/tencent-im-flutter/gx2vx5) | 向群组消息列表中添加一条消息                                      |
| [downloadVideo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                          | 下载视频                                                       |
| [downloadVideoThumbnail](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                 | 下载视频缩略图                                                  |
| [downloadSound](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                          | 下载语音                                                       |
| [createGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                            | 创建群                                                         |
| [joinGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                              | 加入群                                                         |
| [quitGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                              | 退出群                                                         |
| [dismissGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                           | 解散群                                                         |
| [getJoinedGroupList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                     | 获取已经加入的群列表（不包括已加入的直播群）                        |
| [getGroupsInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                          | 拉取群资料                                                     |
| [setGroupInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                           | 修改群资料                                                     |
| [setReceiveMessageOpt](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                   | 设置群消息接收选项                                              |
| [initGroupAttributes](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                    | 初始化群属性，会清空原有的群属性列表                               |
| [setGroupAttributes](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                     | 设置群属性。已有该群属性则更新其 value 值，没有该群属性则添加该属性。 |
| [deleteGroupAttributes](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                  | 删除指定群属性，keys 传 null 则清空所有群属性。。                  |
| [getGroupAttributes](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                     | 获取指定群属性，keys 传 null 则获取所有群属性。                    |
| [getGroupMemberList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                     | 获得群成员列表                                                  |
| [getGroupMembersInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                    | 获取指定的群成员资料                                             |
| [setGroupMemberInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                     | 修改指定的群成员资料                                             |
| [muteGroupMember](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                        | 禁言（只有管理员或群主能够调用）                                  |
| [inviteUserToGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                      | 邀请他人入群                                                    |
| [kickGroupMember](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                        | 踢人                                                           |
| [setGroupMemberRole](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                     | 切换群成员角色                                                  |
| [transferGroupOwner](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                     | 转让群主                                                       |
| [getGroupApplicationList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                | 获取加群申请列表                                                |
| [acceptGroupApplication](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                 | 同意某一条加群申请                                              |
| [refuseGroupApplication](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                 | 拒绝某一条加群申请                                              |
| [setGroupApplicationRead](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                | 标记申请列表为已读                                              |
| [getConversationList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                    | 获得会话列表                                                    |
| [getConversation](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                        | 获得指定会话                                                    |
| [deleteConversation](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                     | 删除会话                                                       |
| [setConversationDraft](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                   | 设置会话草稿                                                    |
| [getUsersInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                           | 获取用户资料                                                    |
| [setSelfInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                            | 修改个人资料                                                    |
| [addToBlackList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                         | 添加用户到黑名单                                                |
| [deleteFromBlackList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                    | 从黑名单中删除                                                  |
| [getBlackList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                           | 获得黑名单列表                                                  |
| [setOfflinePushConfig](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                   | 设置离线推送配置                                                |
| [setUnreadBadge](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                         | 设置未读桌标                                                    |
| [getFriendList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                          | 获取好友列表                                                    |
| [getFriendsInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                         | 获取指定好友信息                                                |
| [setFriendInfo](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                          | 设置好友资料                                                    |
| [addFriend](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                              | 添加好友                                                       |
| [deleteFromFriendList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                   | 删除好友                                                       |
| [checkFriend](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                            | 检查指定用户的好友关系                                           |
| [getFriendApplicationList](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)               | 获取好友申请列表                                                |
| [acceptFriendApplication](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                | 同意好友申请                                                    |
| [refuseFriendApplication](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                | 拒绝好友申请                                                    |
| [deleteFriendApplication](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                | 删除好友申请                                                    |
| [setFriendApplicationRead](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)               | 设置好友申请为已读                                              |
| [createFriendGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                      | 新建好友分组                                                    |
| [getFriendGroups](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                        | 获得分组信息                                                    |
| [deleteFriendGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                      | 删除好友分组                                                    |
| [renameFriendGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)                      | 修改好友分组名称                                                |
| [deleteFriendsFromFriendGroup](https://www.yuque.com/jiangjuhong/tencent-im-flutter/)           | 从分组中删除好友                                                |


> 发送消息

| 参数名称         | 参数描述                                                               | 参数类型               |
|:----------------|:----------------------------------------------------------------------|:----------------------|
| receiver        | 消息接收者的 userID, 如果是发送 C2C 单聊消息，只需要指定 receiver 即可。    | String                |
| groupID         | 目标群组 ID，如果是发送群聊消息，只需要指定 groupID 即可。                 | String                |
| node            | 消息节点                                                               | MessageNode           |
| ol              | 是否为在线消息(无痕)，如果为true，将使用 sendOnlineMessage 通道进行消息发送 | bool                  |
| localCustomInt  | 自定义Int                                                             | int                   |
| localCustomStr  | 自定义Str                                                             | String                |
| priority        | 优先级                                                                | MessagePriorityEnum   |
| offlinePushInfo | 离线推送信息                                                           | OfflinePushInfoEntity |

**使用：**

```dart
TencentRtcPlugin.sendMessage(
  receiver: "123",
  node: TextMessageNode(content: "123"),
);
```


