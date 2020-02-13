# tencent_im_plugin

腾讯云IM插件

## Getting Started
集成腾讯云IM SDK，同时支持 Android 和 IOS

## 功能清单
[x]初始化  
[x]登录相关  
[x]消息收发    
[x]未读计数  
[x]群组相关  
[x]用户资料与关系链  
[ ]离线推送  

## 集成
### Flutter
```
tencent_im_plugin:
    git:
      url: https://github.com/JiangJuHong/FlutterTencentImPlugin.git
      ref: master
```
暂不支持通过版本号引入


### Android 端集成
无需额外配置，已内部打入混淆配置

### IOS
无需额外配置

## 使用
Demo截图:  
<img src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/1.png" height="300em" style="max-width:100%;display: inline-block;"/>
<img src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/2.png" height="300em" style="max-width:100%;display: inline-block;"/>
<img src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/3.png" height="300em" style="max-width:100%;display: inline-block;"/>
<img src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/4.png" height="300em" style="max-width:100%;display: inline-block;"/>
<img src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/5.png" height="300em" style="max-width:100%;display: inline-block;"/>
<img src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/6.png" height="300em" style="max-width:100%;display: inline-block;"/>
<img src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/7.png" height="300em" style="max-width:100%;display: inline-block;"/>
<img src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/8.png" height="300em" style="max-width:100%;display: inline-block;"/>

## 功能清单
|  节点  |  进度  |  说明  |
|  ----  | ---- |  ---- |
|  TIMCustomElem  |  √ |  已完成 |
|  TIMFaceElem  |  - |  暂不考虑 |
|  TIMFileElem  |  - |  暂不考虑，建议使用 TIMCustomElem 代替 |
|  TIMGroupSystemElem  |  - |  暂不考虑 |
|  TIMGroupTipsElem  |  - |  暂不考虑 |
|  TIMImageElem  |  √ |  已完成 |
|  TIMLocationElem  |  - |  计划内 |
|  TIMProfileSystemElem  |  - |  暂不考虑 |
|  TIMSNSSystemElem  |  - |  暂不考虑 |
|  TIMSoundElem  |  ⊙ |  有缺陷，但不影响使用 |
|  TIMTextElem  |  √ |  已完成 |
|  TIMVideoElem  |  ⊙ |  有缺陷，但不影响使用 |

|  接口   | 说明  | 参数  | Android | IOS |
|  ----  | ----  | ----  | ----  | ----  |
| init  | 初始化 | {appid:"xxxxxx"} | √ | √
| login  | 登录 | {identifier:'用户ID',userSig:'用户签名'} | √ | √
| logout  | 登出 | - | √ | √
| getLoginUser  | 获得当前登录用户ID | - | √ | √
| initStorage  | 初始化本地存储 | {identifier: '用户ID'} | √ | √
| getConversationList  | 获得会话列表 | - | √ | √ 
| getConversation  | 获得单个会话 | {id:'会话ID',sessionType:'会话类型} | √ | √ 
| getGroupInfo  | 获得群信息(云端) | {id:'群ID'} | √ | √
| getUserInfo  | 获得用户信息 | {id:'用户ID',forceUpdate:"是否从云端拉取数据，默认为false"} | √ | √
| setRead  | 设置已读 | {sessionId:'会话ID',sessionType:'会话类型，枚举值:SessionType' } | √ | √
| getMessages  | 获得消息列表 | {sessionId:'会话ID',sessionType:'会话类型，枚举值:SessionType',number:"会话数量"} | √ | √
| getLocalMessages  | 获得本地消息列表 | {sessionId:'会话ID',sessionType:'会话类型，枚举值:SessionType',number:"会话数量"} | √ | √
| sendCustomMessage  | 发送自定义消息 | {sessionId:'会话ID',sessionType:'会话类型，枚举值:SessionType',ol:"是否是在线消息（无痕）",data:"数据内容"} | √ | √
| sendTextMessage  | 发送文本消息 | {sessionId:'会话ID',sessionType:'会话类型，枚举值:SessionType',ol:"是否是在线消息（无痕）",content:"文本内容"} | √ | √
| sendSoundMessage  | 发送语音消息 | - | √ | 
| sendImageMessage  | 发送图片消息 | - | √ | 
| sendVideoMessage  | 发送视频消息 | - | √ | 
| getFriendList  | 获得好友列表 | - | √ | 
| getGroupList  | 获得群组列表 | - | √ | 
| addFriend  | 添加好友 | - | √ | 
| checkSingleFriends  | 检测单个好友关系 | - | √ | 
| getPendencyList  | 获得未决好友列表(申请中) | - | √ | 
| pendencyReport  | 未决已读上报 | - | √ | 
| deletePendency  | 未决删除 | - | √ | 
| examinePendency  | 未决审核 | - | √ | 
| deleteConversation  | 删除会话 | - | √ | 
| deleteLocalMessage  | 删除会话内的本地聊天记录 | - | √ | 
| createGroup  | 创建群组 | - | √ | 
| inviteGroupMember  | 邀请加入群组 | - | √ | 
| applyJoinGroup  | 申请加入群组 | - | √ | 
| quitGroup  | 退出群组 | - | √ | 
| deleteGroupMember  | 删除群组成员 | - | √ | 
| getGroupMembers  | 获得群成员列表 | - | √ | 
| deleteGroup  | 解散群组 | - | √ | 
| modifyGroupOwner  | 转让群组 | - | √ | 
| modifyGroupInfo  | 修改群组资料 | - | √ | 
| modifyMemberInfo  | 修改群成员资料 | - | √ | 
| getGroupPendencyList  | 获得未决群列表 | - | √ | 
| reportGroupPendency  | 上报群未决已读 | - | √ | 
| groupPendencyAccept  | 群未决审核（同意） | - | √ | 
| groupPendencyRefuse  | 群未决审核（拒绝） | - | √ | 
| getSelfProfile  | 获取登录用户资料 | - | √ | 
| modifySelfProfile  | 修改登录用户资料 | - | √ | 
| modifyFriend  | 修改好友资料 | - | √ | 
| deleteFriends  | 删除好友 | - | √ | 
| addBlackList  | 添加到黑名单 | - | √ | 
| deleteBlackList  | 从黑名单删除 | - | √ | 
| getBlackList  | 获得黑名单列表 | - | √ | 
| createFriendGroup  | 创建好友分组 | - | √ | 
| deleteFriendGroup  | 删除好友分组 | - | √ | 
| addFriendsToFriendGroup  | 添加好友到某个分组 | - | √ | 
| deleteFriendsFromFriendGroup  | 从分组删除好友 | - | √ | 
| renameFriendGroup  | 重命名分组 | - | √ | 
| getFriendGroups  | 获得好友分组 | - | √ | 