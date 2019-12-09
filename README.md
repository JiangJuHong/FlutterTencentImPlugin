# tencent_im_plugin

腾讯云IM插件

## Getting Started

## Android 端集成

### 1. 修改 defaultConfig ndk 配置
```
defaultConfig {
    .......
    ndk {
        abiFilters "armeabi-v7a"
    }
}
buildTypes {
    release {
        .......
        ndk {
            abiFilters "armeabi-v7a"
        }
    }
    debug {
        .......
        ndk {
            abiFilters "armeabi", "armeabi-v7a", "arm64-v8a", "x86"
        }
    }
}
```
### 2. 设置混淆规则
```
-keep class com.tencent.** { *; }
```

### 3. 如果启动报错，请修改 AndroidManifest.xml 文件
在 manifest 标签上增加:``xmlns:tools="http://schemas.android.com/tools"``
在 application 标签上增加:``tools:replace="android:label"``

## IOS端集成

## 使用
### 初始化
通过调用 ``TencentImPlugin.init(appid: "xxxxxxx");`` 进行初始化
注意：该方法必须调用且最好仅调用一次，建议在程序启动时调用一次即可。

### 登录
通过调用 ``TencentImPlugin.login(identifier: "用户ID",userSig:"签名，建议通过服务端生成");`` 进行登录
注意：如果已有用户登录，则登录方法会被中断且返回异常!

### 退出登录
如果您需要登出，可以调用：``TencentImPlugin.logout();``

### 获得当前登录用户
``TencentImPlugin.getLoginUser();`` 返回值为当前登录用户ID

### 初始化本地存储
``TencentImPlugin.initStorage(identifier: "用户ID");`` 

### 获得当前登录用户会话列表
``TencentImPlugin.getConversationList();`` 返回值为``List<SessionEntity>``
会话列表时，对象内的 message 对象仅包含: id、elemList、timestamp 字段

### 根据群ID获取群信息
``TencentImPlugin.getGroupInfo();``
会优先读取本地数据，如果本地没有数据，则走云端拉取

### 根据用户ID获取用户信息
``TencentImPlugin.getUserInfo();``

### 获得当前登录用户信息
``TencentImPlugin.getLoginUserInfo();``

### 获取消息列表
``TencentImPlugin.getMessages(sessionId:"",sessionType:SessionType.xxx,number:100,);``

### 获取本地消息列表
``TencentImPlugin.getLocalMessages(sessionId:"",sessionType:SessionType.xxx,number:100,);``

### 设置会话消息为已读
``TencentImPlugin.setRead(sessionId:"",sessionType:SessionType.xxx)``

### 添加和移除监听
``TencentImPlugin.addListener((type,params){....})`` ``TencentImPlugin.removeListener((type,params){....})``
当事件被触发时调用，但是注意，不同类型所返回的参数值也有所不同

### 发送文本消息
``TencentImPlugin.sendTextMessage(sessionId:"",sessionType:SessionType.xxx,content:"xxxxxx")``

### 发送语音消息
``TencentImPlugin.sendSoundMessage(sessionId:"",sessionType:SessionType.xxx,duration:时长，整型,path:"语音资源路径")``
Example中，录音插件使用: flutter_sound，权限请求插件使用: permission_handler
下载语音消息时为异步，有可能出现界面渲染但是还没下载结束的问题，再次，可通过监听器类型:DownloadStart、DownloadSuccess和DownloadFail监听，以uuid作为唯一标识符
语音下载拥有缓存，只会在第一次时下载

### 发送图片消息
``TencentImPlugin.sendImageMessage(sessionId:"",sessionType:SessionType.xxx,path:"图片资源路径")``
Example中，图片选择插件使用：image_picker

### 发送视频消息
``TencentImPlugin.sendVoiceMessage(sessionId:"",sessionType:SessionType.xxx,path:"视频资源路径",type:"视频类型，如mp4",duration:时长(秒),snapshotWidth:截图宽度,snapshotHeight:截图高度,snapshotPath:"截图路径")``
Example中，视频选择插件使用：image_picker，视频播放和信息获取插件为:flutter_ijkplayer，视频缩略图插件使用：thumbnails
下载视频封面和视频时为异步，有可能出现界面渲染但是还没下载结束的问题，再次，可通过监听器类型:DownloadSuccess和DownloadFail监听，以uuid作为唯一标识符
视频下载拥有缓存，只会在第一次时下载

### 获得好友列表
``TencentImPlugin.getFriendList()``

### 获得群组列表
``TencentImPlugin.getGroupList()``

### 添加好友
``TencentImPlugin.addFriend(id: 用户ID,remark: 备注,addWording: 申请说明,addSource: 添加来源,friendGroup: 分组)``

### 检测单个好友关系
``TencentImPlugin.checkSingleFriends(id:用户ID,type:FriendCheckTypeEnum.unidirection)``

## 对象实体说明