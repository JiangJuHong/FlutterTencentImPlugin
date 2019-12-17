# tencent_im_plugin

腾讯云IM插件

## Getting Started

## 功能清单
[x]初始化  
[x]登录相关  
[-]消息收发    
[x]未读计数  
[-]群组相关  
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
如果启动报错，请修改 AndroidManifest.xml 文件  
在 manifest 标签上增加:``xmlns:tools="http://schemas.android.com/tools"``
在 application 标签上增加:``tools:replace="android:label"``

### IOS
暂不支持

## 使用
<img src="https://github.com/JiangJuHong/access-images/blob/master/FlutterTencentImPlugin/1.png?raw=true" height="300em" style="max-width:100%;">
<img src="https://github.com/JiangJuHong/access-images/blob/master/FlutterTencentImPlugin/2.png?raw=true" height="300em" style="max-width:100%;">
<img src="https://github.com/JiangJuHong/access-images/blob/master/FlutterTencentImPlugin/3.png?raw=true" height="300em" style="max-width:100%;">
<img src="https://github.com/JiangJuHong/access-images/blob/master/FlutterTencentImPlugin/4.png?raw=true" height="300em" style="max-width:100%;">
<img src="https://github.com/JiangJuHong/access-images/blob/master/FlutterTencentImPlugin/5.png?raw=true" height="300em" style="max-width:100%;">
<img src="https://github.com/JiangJuHong/access-images/blob/master/FlutterTencentImPlugin/6.png?raw=true" height="300em" style="max-width:100%;">
<img src="https://github.com/JiangJuHong/access-images/blob/master/FlutterTencentImPlugin/7.png?raw=true" height="300em" style="max-width:100%;">
<img src="https://github.com/JiangJuHong/access-images/blob/master/FlutterTencentImPlugin/8.png?raw=true" height="300em" style="max-width:100%;">


### 登录
---

#### 初始化

#### 登录

#### 初始化本地存储(可以在无网络情况下加载本地会话和消息)

#### 退出登录

#### 获得当前登录用户ID

#### 获得当前登录用户信息

### 消息收发
---

#### 文本消息发送

#### 图片消息发送

#### 表情消息发送(暂不支持)

#### 语音消息发送

#### 发送地理位置(暂不支持)

#### 小文件发送(暂不支持)

#### 自定义消息发送

#### 短视频发送

#### 文本消息接收

#### 图片消息接收

#### 语音消息接收

#### 小文件消息接收(暂不支持)

#### 短视频消息接收

#### 获取会话列表

#### 获取本地消息

#### 获得漫游(服务器上)的消息

#### 设置会话操作(暂不支持)

#### 删除会话

#### 删除会话本地消息 - 批量删除本会话的全部本地聊天记录

#### 查找本地消息(暂不支持)

#### 消息撤回(暂不支持)

### 未读计数
---

#### 已读上报

### 群组相关
---

#### 创建群组

#### 邀请用户加入群组

#### 申请加入群组

#### 退出群组

#### 删除群组成员

#### 获取群成员列表

#### 获取群组列表

#### 解散群组

#### 转让群组

#### 获取群组资料

#### 获取本人在群内的资料(暂不支持)

#### 获取群内某个人的资料(暂不支持)

#### 修改群资料

#### 修改群成员资料

#### 获得群未决列表

#### 上报未决已读

#### 未决审核同意【谨慎使用】

#### 未决审核拒绝【谨慎使用】

### 用户资料与关系链
--- 

#### 获取自己的资料

#### 获取指定用户资料

#### 修改自己资料

#### 获取所有好友

#### 修改好友资料

#### 添加好友

#### 删除好友

#### 同意/拒绝好友申请

#### 校验好友关系

#### 获取未决列表

#### 未决删除

#### 未决已读上报

#### 添加用户到黑名单

#### 从黑名单删除

#### 获得黑名单列表

#### 创建好友分组

#### 删除好友分组

#### 添加好友到某分组

#### 从某分组删除好友

#### 重命名好友分组

#### 获取好友分组

### 离线推送
---  
暂不支持