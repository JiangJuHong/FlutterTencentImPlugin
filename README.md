# tencent_im_plugin

[![pub package](https://img.shields.io/pub/v/tencent_im_plugin.svg)](https://pub.dartlang.org/packages/tencent_im_plugin)

腾讯云IM插件

## Getting Started

集成腾讯云IM SDK，同时支持 Android 和 IOS，支持离线推送.  
错误码参考:
[点我进入](https://cloud.tencent.com/document/product/269/1671)  
IMSDK版本:

| 平台    | 版本     | 文档地址                                                         |
|:--------|:--------|:----------------------------------------------------------------|
| Android | v4.6.1  | [Android](https://cloud.tencent.com/document/product/269/36909) |
| IOS     | v4.6.58 | [IOS](https://cloud.tencent.com/document/product/269/36910)     |

## 功能清单

\[x]初始化  
\[x]登录相关  
\[x]消息收发  
\[x]未读计数  
\[x]群组相关  
\[x]用户资料与关系链  
\[x]离线推送

### 近期计划(已完成内容将会被移除)

\[] 验证 群提示消息修改时 不能获取到具体类型的问题  
\[] 升级IM SDK版本  
\[] 优化使用文档

### 最新消息

1. 由于腾讯云服务端升级，已经不支持删除云端消息记录，该特性将在后续版本中移除.
2. 由于腾讯云SDK版本升级，部分接口与腾讯云最新SDK不一致，请参考腾讯云文档时查阅上面版本附带的文档地址.

## 集成

### Flutter

```
tencent_im_plugin: ^[最新版本号]
```

### Android 端集成

无需额外配置，已内部打入混淆配置

### IOS

无需额外配置

## 使用

Demo截图:  
<img
src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/1.png"
height="300em" style="max-width:100%;display: inline-block;"/> <img
src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/2.png"
height="300em" style="max-width:100%;display: inline-block;"/> <img
src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/3.png"
height="300em" style="max-width:100%;display: inline-block;"/> <img
src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/4.png"
height="300em" style="max-width:100%;display: inline-block;"/> <img
src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/5.png"
height="300em" style="max-width:100%;display: inline-block;"/> <img
src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/6.png"
height="300em" style="max-width:100%;display: inline-block;"/> <img
src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/7.png"
height="300em" style="max-width:100%;display: inline-block;"/> <img
src="https://raw.githubusercontent.com/JiangJuHong/access-images/master/FlutterTencentImPlugin/8.png"
height="300em" style="max-width:100%;display: inline-block;"/>

## 功能清单

### 消息发送节点

| 节点                | 进度 | 说明       |
|:--------------------|:----|:----------|
| TextMessageNode     | √   | 文本消息   |
| ImageMessageNode    | √   | 图片消息   |
| SoundMessageNode    | √   | 语音消息   |
| VideoMessageNode    | √   | 视频消息   |
| CustomMessageNode   | √   | 自定义消息 |
| LocationMessageNode | √   | 位置消息   |

### 消息接收节点

| 节点                 | 进度 | 说明                                             |
|:---------------------|:----|:------------------------------------------------|
| TIMCustomElem        | √   | 已完成                                           |
| TIMFaceElem          | -   | 暂不考虑，建议使用 TIMCustomElem 代替              |
| TIMFileElem          | -   | 暂不考虑，建议使用 TIMCustomElem 代替              |
| TIMGroupSystemElem   | √   | 已完成                                           |
| TIMGroupTipsElem     | √   | 已完成                                           |
| TIMImageElem         | √   | 已完成                                           |
| TIMLocationElem      | √   | 已完成                                           |
| TIMProfileSystemElem | √   | 已完成                                           |
| TIMSNSSystemElem     | √   | 已完成                                           |
| TIMSoundElem         | √   | 已完成                                           |
| TIMTextElem          | √   | 已完成                                           |
| TIMVideoElem         | √   | 已完成                                           |
| OtherMessageNode     | √   | 已完成，仅Android（IOS能够解析，但是内容体没有数据） |

### 接口(右滑查看详细参数)

| 接口                          | 说明                                                                                                                                     | 参数                                                                                                                                                                                                                              | Android | IOS |
|:------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------|:----|
| init                          | 初始化                                                                                                                                   | {appid:"xxxxxx",enabledLogPrint:"是否启用日志打印",logPrintLevel:"日志打印级别"}                                                                                                                                                     | √       | √   |
| login                         | 登录                                                                                                                                     | {identifier:'用户ID',userSig:'用户签名'}                                                                                                                                                                                           | √       | √   |
| logout                        | 登出                                                                                                                                     | -                                                                                                                                                                                                                                | √       | √   |
| getLoginUser                  | 获得当前登录用户ID                                                                                                                        | -                                                                                                                                                                                                                                 | √       | √   |
| initStorage                   | 初始化本地存储(如果这个方法在 login 后进行 await 调用，则会造成卡死)                                                                           | {identifier: '用户ID'}                                                                                                                                                                                                            | √       | √   |
| getConversationList           | 获得会话列表(如果是离线状态，则获取出来的会话列表不包含: Group、UserProfile 信息)                                                               | -                                                                                                                                                                                                                                | √       | √   |
| getConversation               | 获得单个会话(如果是离线状态，则获取出来的会话列表不包含: Group、UserProfile 信息)                                                               | {id:'会话ID',sessionType:'会话类型}                                                                                                                                                                                                | √       | √   |
| getGroupInfo                  | 获得群信息(云端)                                                                                                                          | {id:'群ID'}                                                                                                                                                                                                                       | √       | √   |
| getUserInfo                   | 获得用户信息                                                                                                                              | {id:'用户ID',forceUpdate:"是否从云端拉取数据，默认为false"}                                                                                                                                                                          | √       | √   |
| setRead                       | 设置已读                                                                                                                                 | {sessionId:'会话ID',sessionType:'会话类型，枚举值:SessionType' }                                                                                                                                                                    | √       | √   |
| getMessages                   | 获得消息列表(如果是离线状态，则获取出来的消息不包含 UserProfile 信息)                                                                          | {sessionId:'会话ID',sessionType:'会话类型，枚举值:SessionType',number:"会话数量",lastMessage:'最后一条消息'}                                                                                                                           | √       | √   |
| getLocalMessages              | 获得本地消息列表(如果是离线状态，则获取出来的消息不包含 UserProfile 信息)                                                                       | {sessionId:'会话ID',sessionType:'会话类型，枚举值:SessionType',number:"会话数量",lastMessage:'最后一条消息'}                                                                                                                          | √       | √   |
| sendMessage                   | 发送消息                                                                                                                                 | {sessionId:'会话ID',sessionType:'会话类型，枚举值:SessionType',ol:"是否是在线消息（无痕）",node:消息节点对象}                                                                                                                            | √       | √   |
| saveMessage                   | 向本地消息列表中添加一条消息，但并不将其发送出去。                                                                                             | {sessionId:'会话ID',sessionType:'会话类型，枚举值:SessionType',node:消息节点对象,sender:"发送人",isReaded:'是否已读'}                                                                                                                  | √       | √   |
| getFriendList                 | 获得好友列表                                                                                                                              | -                                                                                                                                                                                                                                | √       | √   |
| getGroupList                  | 获得群组列表                                                                                                                              | -                                                                                                                                                                                                                                | √       | √   |
| addFriend                     | 添加好友                                                                                                                                 | {id:'用户ID',addType:'添加类型',remark:'备注',addWording:'请求说明',addSource:'添加来源',friendGroup:'分组名'}                                                                                                                         | √       | √   |
| checkSingleFriends            | 检测单个好友关系                                                                                                                          | {id:'用户ID',type:'检测类型'}                                                                                                                                                                                                      | √       | √   |
| getPendencyList               | 获得未决好友列表(申请中)                                                                                                                   | {type:'类型',seq:'未决列表序列号',timestamp:'翻页时间戳',numPerPage:'每页数量'}                                                                                                                                                       | √       | √   |
| pendencyReport                | 未决已读上报                                                                                                                              | {timestamp:"时间戳"}                                                                                                                                                                                                              | √       | √   |
| deletePendency                | 未决删除                                                                                                                                 | {id:'用户Id',type:'类型'}                                                                                                                                                                                                          | √       | √   |
| examinePendency               | 未决审核                                                                                                                                 | {id:'用户ID',type:'类型',remark:'备注'}                                                                                                                                                                                            | √       | √   |
| deleteConversation            | 删除会话                                                                                                                                 | {sessionId:'会话ID',sessionType:'会话类型，枚举值:SessionType',removeCache:'是否删除本地消息缓存'}                                                                                                                                     | √       | √   |
| deleteLocalMessage            | 删除会话内的本地聊天记录                                                                                                                   | {sessionId:'会话ID',sessionType:'会话类型，枚举值:SessionType'}                                                                                                                                                                     | √       | √   |
| createGroup                   | 创建群组                                                                                                                                 | {groupId:'指定群ID',notification:'群公告',introduction:'描述',faceUrl:'头像',addOption:'入群类型',maxMemberNum:'最大成员数量',members:'成员集合',type:'类型',name:'群名',customInfo:'自定义数据'}                                         | √       | √   |
| inviteGroupMember             | 邀请加入群组                                                                                                                              | {groupId:'群ID',ids:'群成员ID'}                                                                                                                                                                                                   | √       | √   |
| applyJoinGroup                | 申请加入群组                                                                                                                              | {groupId:'群ID',reason:'申请说明'}                                                                                                                                                                                                 | √       | √   |
| quitGroup                     | 退出群组                                                                                                                                 | {groupId:'群ID'}                                                                                                                                                                                                                  | √       | √   |
| deleteGroupMember             | 删除群组成员                                                                                                                              | {groupId:'群ID',ids:'用户ID集合',reason:"删除说明"}                                                                                                                                                                                 | √       | √   |
| getGroupMembers               | 获得群成员列表                                                                                                                            | {groupId:'群ID'}                                                                                                                                                                                                                  | √       | √   |
| deleteGroup                   | 解散群组                                                                                                                                 | {groupId:'群ID'}                                                                                                                                                                                                                  | √       | √   |
| modifyGroupOwner              | 转让群组                                                                                                                                 | {groupId:'群ID',identifier:'新群主ID'}                                                                                                                                                                                             | √       | √   |
| modifyGroupInfo               | 修改群组资料                                                                                                                              | {groupId:'指定群ID',notification:'群公告',introduction:'描述',faceUrl:'头像',addOption:'入群类型',maxMemberNum:'最大成员数量(IOS不支持)',type:'类型',groupName:'群名',visable:'是否对外可见',silenceAll:'全员禁言',customInfo:'自定义信息'} | √       | √   |
| modifyMemberInfo              | 修改群成员资料                                                                                                                            | {groupId:'群ID',identifier:'群成员ID',nameCard:'名片',receiveMessageOpt:'接收消息选项，注:IOS不支持',silence:'禁言时间',role:'角色',customInfo:'自定义数据'}                                                                             | √       | √   |
| getGroupPendencyList          | 获得未决群列表                                                                                                                            | {timestamp:'翻页时间戳',numPerPage:'每页的数量'}                                                                                                                                                                                    | √       | √   |
| reportGroupPendency           | 上报群未决已读                                                                                                                            | {timestamp:'已读时间戳'}                                                                                                                                                                                                           | √       | √   |
| groupPendencyAccept           | 群未决审核（同意）会遍历所有未决列表来获得未审核的列表，存在性能隐患                                                                             | {msg:'审核意见',groupId:'群ID',identifier:'申请人ID',addTime:'申请时间'}                                                                                                                                                            | √       | √   |
| groupPendencyRefuse           | 群未决审核（拒绝）会遍历所有未决列表来获得未审核的列表，存在性能隐患                                                                             | {msg:'审核意见',groupId:'群ID',identifier:'申请人ID',addTime:'申请时间'}                                                                                                                                                            | √       | √   |
| getSelfProfile                | 获取登录用户资料                                                                                                                          | {forceUpdate:"是否强制走后台拉取"}                                                                                                                                                                                                  | √       | √   |
| modifySelfProfile             | 修改登录用户资料 [字段参考文档](https://cloud.tencent.com/document/product/269/1500#.E6.A0.87.E9.85.8D.E8.B5.84.E6.96.99.E5.AD.97.E6.AE.B5) | {params:'修改参数'}                                                                                                                                                                                                               | √       | √   |
| modifyFriend                  | 修改好友资料 [字段参考文档](https://cloud.tencent.com/document/product/269/1500#.E6.A0.87.E9.85.8D.E8.B5.84.E6.96.99.E5.AD.97.E6.AE.B5)    | {identifier:'好友ID',params:'修改参数'}                                                                                                                                                                                            | √       | √   |
| deleteFriends                 | 删除好友                                                                                                                                 | {ids:"用户ID列表",delFriendType:'删除类型'}                                                                                                                                                                                         | √       | √   |
| addBlackList                  | 添加到黑名单                                                                                                                              | {ids:"用户ID列表"}                                                                                                                                                                                                                | √       | √   |
| deleteBlackList               | 从黑名单删除                                                                                                                              | {ids:"用户ID列表"}                                                                                                                                                                                                                | √       | √   |
| getBlackList                  | 获得黑名单列表                                                                                                                            | -                                                                                                                                                                                                                                 | √       | √   |
| createFriendGroup             | 创建好友分组                                                                                                                              | {groupNames:'组名列表',ids:'用户列表'}                                                                                                                                                                                             | √       | √   |
| deleteFriendGroup             | 删除好友分组                                                                                                                              | {groupNames:'组名列表'}                                                                                                                                                                                                           | √       | √   |
| addFriendsToFriendGroup       | 添加好友到某个分组                                                                                                                         | {groupName:'组名',ids:'ID列表'}                                                                                                                                                                                                   | √       | √   |
| deleteFriendsFromFriendGroup  | 从分组删除好友                                                                                                                            | {groupName:'组名',ids:'ID列表'}                                                                                                                                                                                                    | √       | √   |
| renameFriendGroup             | 重命名分组                                                                                                                                | {oldGroupName:'旧名称',newGroupName:'新名称'}                                                                                                                                                                                      | √       | √   |
| getFriendGroups               | 获得好友分组                                                                                                                              | {groupNames:'组名'}                                                                                                                                                                                                               | √       | √   |
| revokeMessage                 | 撤回一条发送成功的消息                                                                                                                     | {message:'消息对象'}                                                                                                                                                                                                               | √       | √   |
| removeMessage                 | 删除一条消息(本地)                                                                                                                        | {message:'消息对象'}                                                                                                                                                                                                               | √       | √   |
| setMessageCustomInt           | 设置自定义整数                                                                                                                            | {message:'消息对象',value:'自定义值'}                                                                                                                                                                                               | √       | √   |
| setMessageCustomStr           | 设置自定义整数                                                                                                                            | {message:'消息对象',value:'自定义值'}                                                                                                                                                                                               | √       | √   |
| downloadVideoImage            | 获得视频图片(缩略图)                                                                                                                       | {message:'消息对象',path:'保存截图的路径'}                                                                                                                                                                                          | √       | √   |
| downloadVideo                 | 获得视频                                                                                                                                 | {message:'消息对象',path:'保存视频的路径'}                                                                                                                                                                                           | √       | √   |
| downloadSound                 | 获得语音                                                                                                                                 | {message:'消息对象',path:'保存语音的路径'}                                                                                                                                                                                           | √       | √   |
| findMessage                   | 查找一条消息                                                                                                                              | {sessionId:'会话ID',sessionType:'会话类型',rand:'随机码',seq:'消息系列号',timestamp:'消息时间戳',self:'是否是自己发送的消息'}                                                                                                            | √       | √   |
| setOfflinePushSettings        | 设置离线推送相关设置(请保证该方法在登录后调用)                                                                                                | {enabled:'是否启用',c2cSound:'C2C音频文件',groupSound:'Group音频文件',videoSound:'视频邀请语音'}                                                                                                                                      | √       | √   |
| setOfflinePushToken           | 设置离线推送相关Token(登录之后调用)                                                                                                         | {token:'各个手机厂商的推送服务对客户端的唯一标识，需要集成各个厂商的推送服务获取',bussid:'推送证书 ID，是在 IM 控制台上生成的'}                                                                                                               | √       | √   |
| setMessageOfflinePushSettings | 设置单条消息的离线推送配置                                                                                                                  | {sessionId:'会话ID',sessionType:'会话类型',rand:'随机码',seq:'消息系列号',timestamp:'消息时间戳',self:'是否是自己发送的消息'}                                                                                                           | √       | √   |

### 消息监听

通过 `TencentImPlugin.addListener` 和 `TencentImPlugin.removeListener`
可进行事件监听

````dart
@override
vodi initState(){
  super.initState();
  TencentImPlugin.addListener(_messageListener);
}
@override
void dispose() {
  super.dispose();
  TencentImPlugin.removeListener(_messageListener);
}

 _messageListener(ListenerTypeEnum type, params) {
  // you code
};
````

注意：addListener 后，请注意在必要时进行 removeListener

### 离线推送

注意:
本插件仅在腾讯云IM上进行封装，并未集成小米、华为等推送方的SDK，故集成离线推送时根据腾讯云文档进行集成。已封装离线推送配置方法。  
如果你要集成

#### 离线推送相关接口

`setOfflinePushSettings`:
设置离线推送相关设置，包含：是否启用、C2C消息语音、群聊消息语音和视频邀请语音。请保证该方法在登录后调用！  
`setOfflinePushToken`: 设置离线推送相关Token，token
是各个手机厂商的推送服务对客户端的唯一标识，需要集成各个厂商的推送服务获取；
bussid 是推送证书 ID，是在 IM 控制台上生成的， 具体步骤请参考
https://cloud.tencent.com/document/product/269/9234

#### 1. 插件集成步骤

##### 小米 [xiao_mi_push_plugin](https://github.com/JiangJuHong/FlutterXiaoMiPushPlugin)  [![pub package](https://img.shields.io/pub/v/xiao_mi_push_plugin.svg)](https://pub.dartlang.org/packages/xiao_mi_push_plugin)

0. 引入插件

````
xiao_mi_push_plugin: 1.0.0
````

1. 根据 xiao_mi_push_plugin 插件文档进行配置

2. 初始化以及绑定监听器

````dart
void bindXiaoMiPush(){
  XiaoMiPushPlugin.addListener((type,params){
    if(type == XiaoMiPushListenerTypeEnum.ReceiveRegisterResult){
      TencentImPlugin.setOfflinePushToken(token: params.commandArguments[0],bussid: BUSSID);
    }  
  });
  XiaoMiPushPlugin.init(appId: APP_ID, appKey: APP_KEY);
}
````

3. 消息接收等使用方法请参考
   [xiao_mi_push_plugin](https://github.com/JiangJuHong/FlutterXiaoMiPushPlugin)
   插件

##### 华为 [hua_wei_push_plugin](https://github.com/JiangJuHong/FlutterHuaWeiPushPlugin)  [![pub package](https://img.shields.io/pub/v/hua_wei_push_plugin.svg)](https://pub.dartlang.org/packages/hua_wei_push_plugin)

0. 引入插件

````
hua_wei_push_plugin: 1.0.0
````

1. 根据 hua_wei_push_plugin 插件文档进行配置

2. 获得Token并上传到腾讯云IM

````dart
  void bindHuaWeiPush() {
    HuaWeiPushPlugin.getToken().then((token) {
      TencentImPlugin.setOfflinePushToken(token: token, bussid: BUSSID);
    }).catchError((e) {
      print("华为离线推送绑定失败!");
    });
  }
````

##### 魅族推送

暂无符合要求的插件

##### OPPO 推送

暂无符合要求的插件

##### vivo 推送

暂无符合要求的插件

##### Google FCM 推送

暂无符合要求的插件

#### Apple

推荐 `flutter-apns`或`apns_flutter`(暂未集成测试)

#### 2. 自行集成步骤

[Android](https://cloud.tencent.com/document/product/269/44516)  
[IOS](https://cloud.tencent.com/document/product/269/44517)

## 赞助

[https://www.yuque.com/jiangjuhong/default/aso8g5](https://www.yuque.com/jiangjuhong/default/aso8g5)
感谢您的赞助!

## 其它插件

````
我同时维护的还有以下插件，如果您感兴趣与我一起进行维护，请通过Github联系我，欢迎 issues 和 PR。
````

| 平台    | 插件                                                                                       | 描述                   | 版本                                                                                                                           |
|:--------|:------------------------------------------------------------------------------------------|:-----------------------|:------------------------------------------------------------------------------------------------------------------------------|
| Flutter | [FlutterTencentImPlugin](https://github.com/JiangJuHong/FlutterTencentImPlugin)           | 腾讯云IM插件            | [![pub package](https://img.shields.io/pub/v/tencent_im_plugin.svg)](https://pub.dartlang.org/packages/tencent_im_plugin)     |
| Flutter | [FlutterTencentRtcPlugin](https://github.com/JiangJuHong/FlutterTencentRtcPlugin)         | 腾讯云Rtc插件           | [![pub package](https://img.shields.io/pub/v/tencent_rtc_plugin.svg)](https://pub.dartlang.org/packages/tencent_rtc_plugin)   |
| Flutter | [FlutterXiaoMiPushPlugin](https://github.com/JiangJuHong/FlutterXiaoMiPushPlugin)         | 小米推送SDK插件         | [![pub package](https://img.shields.io/pub/v/xiao_mi_push_plugin.svg)](https://pub.dartlang.org/packages/xiao_mi_push_plugin) |
| Flutter | [FlutterHuaWeiPushPlugin](https://github.com/JiangJuHong/FlutterHuaWeiPushPlugin)         | 华为推送(HMS Push)插件  | [![pub package](https://img.shields.io/pub/v/hua_wei_push_plugin.svg)](https://pub.dartlang.org/packages/hua_wei_push_plugin) |
| Flutter | [FlutterTextSpanField](https://github.com/JiangJuHong/FlutterTextSpanField)               | 自定义文本样式输入框     | [![pub package](https://img.shields.io/pub/v/text_span_field.svg)](https://pub.dartlang.org/packages/text_span_field)         |
| Flutter | [FlutterClipboardListener](https://github.com/JiangJuHong/FlutterClipboardListener)       | 粘贴板监听器            | [![pub package](https://img.shields.io/pub/v/clipboard_listener.svg)](https://pub.dartlang.org/packages/clipboard_listener)   |
| Flutter | [FlutterQiniucloudLivePlugin](https://github.com/JiangJuHong/FlutterQiniucloudLivePlugin) | Flutter 七牛云直播云插件 | 暂未发布，通过 git 集成                                                                                                         |

