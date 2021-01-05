## 0.1.0
* 集成腾讯云IMSDK，包含Android 和 IOS

## 0.1.1
* 修复Android设备上找不到符号的BUG

## 0.1.2
* 修复IOS上Json字符串中包含特殊字符的问题
* 修复IOS监听器无效的问题

## 0.1.3
* 修复 MessageEntity 中 sessionType 始终为空的问题

## 0.1.4
* 修复 GroupTipsNode 节点nil对象引起闪退问题

## 0.1.5
* 修复 GroupTipsNode 节点nil对象引起闪退问题

## 0.1.6
* 修复IOS上添加好友必须传递所有参数的问题
* 修改 getParam 方法代码结构

## 0.1.7
* 修复IOS上获得未决列表时解析异常的问题

## 0.1.8
* 修复Android设备上自定义消息未解码的问题

## 0.1.9
* 修复安卓上获得单个会话异常

## 0.1.10
* 修复IOS设备上回调数据非JSON类型时多了个 ""

## 0.1.11
* 修复消息解析异常

## 0.1.12
* 移除base64 工具类
* 解决fastjson byte[] 序列化为base64字符串的问题

## 0.1.13
* 修复运行异常

## 0.1.14
* 完成消息撤回功能

## 0.1.15
* 增加删除单条消息功能
* 修改json工具类，解决非字符串类型以字符串类型返回

## 0.1.16
* 修复字符串数组解析JSON时格式问题

## 0.1.17
* 增加设置消息自定义字符串和自定义整型

## 0.1.18
* 增加发送消息后返回消息对象

## 0.1.19
* 兼容所有发送消息后返回消息对象

## 0.1.20
* 会话列表增加能够获得发送人信息

## 0.1.21
* 发送新消息后，返回的数据对象有问题

## 0.1.22
* 修复 setMessageCustomInt 和 setMessageCustomString 报错的问题

## 0.2.0
1. 将发送消息统一更改为 sendMessage ,使用不同消息节点即可发送不同消息
1. MessageEntity 增加 note 属性，对非自定消息可直接用于展示
1. 发送节点和接收实体合二为一，发送时仅需设置构造器参数即可，接收时会自动填充内容
1. 视频、语音，将不再自动下载，提供语音/视频下载方法
1. 视频、语音和图片提供上传/下载进度监听器，分别为:ListenerTypeEnum.UploadProgress/ListenerTypeEnum.DownloadProgress
1. 除 PendencyPageEntity 和 GroupPendencyPageEntity 外的所有Entity 重写 == 和 hashCode，可直接进行判断是否相等

## 0.2.1
* 修订文档

## 0.2.2
* 修改类名称

## 0.2.3
* 修复枚举名称

## 0.2.4
* 图片节点增加清晰度参数
* 图片增加默认值填充

## 0.2.5
* 移除图片节点转换

## 0.2.6
修复ImageNode无法赋值的问题

## 0.2.7
修复自定义消息无法赋值的问题

## 0.2.8
修复删除会话无法删除本地消息的问题

## 0.2.9
* 修复MessageEntity传递方式
* getMessages 和 getLocalMessages 增加根据lastMessage来筛选

## 0.2.10
* 修复 getMessage 和 getLocalMessage 根据lastMessage筛选 无效的问题

## 0.2.11
* 修复IOS无法获得消息的问题

## 0.2.12
* 修复Android获得消息报错

## 0.2.13
* 增加通用节点 Other

## 0.2.14
* 增加GroupTips节点

## 0.2.15
* 升级版本，无改动

## 0.2.16
* 优化：无论是群聊还是个人都会触发撤回回调

## 0.2.17
* 优化：群提示通知、群通知节点，使用同一个实体

## 0.2.18
* 修复：群提示节点userList始终为空的问题

## 0.2.19
* 增加: SNSSystemElem 的解析

## 0.2.20
* 增加：findMessage、saveMessage
* 增加：init 时可配置日志相关内容

## 0.2.21
* 修复：IOS onReConnFailed、onConnFailed和onDisconnect 回调时崩溃的问题

## 0.2.22
* 修复：获取会话用户时，有时候获取不到

## 0.2.23
* 解决代码错误

## 0.2.24
* 修复Android：获取会话用户时，有时候获取不到

## 0.2.25
* 取消Android logout 方法的校验
* 修改离线获取会话列表
* 修改离线获取会话列表
* 修改离线获取消息

## 0.2.26
* 增加监听器文档说明
* 修改 modifyMemberInfo 参数不一致的问题
* 修复Android创建群聊时，无法设置群成员的问题
* 修复IOS创建群聊无法设置群成员问题

## 0.2.27
* 升级IM SDK版本为 4.8.10
* 增加离线推送

## 0.2.28
* 修复 setToken int 无法转换为 long 的问题
* 离线推送注册增加文档说明

## 0.2.30
* 修复 Android Int 转换为 Long 时报错

## 0.2.31
* 创建群组的群成员设置为可选属性

## 0.2.32
* 修复IOS applyJoinGroup 包错问题
* 修复Demo NewMessages 监听器添加数据失败

## 0.2.33
* 修复IOS申请加入群组闪退问题
* 修改申请加入群组 reason 为必传

## 0.2.34
* 修复 Native 和 Flutter 模型参数不一致

## 0.2.35
* 解决群未决处理TIMGroupPendencyItem的selfIdentifier为空的问题

## 0.2.36
* 解决发送图片后可能出现的错误
* createGroup 接口增加 customInfo 信息
* 替换Demo中视频缩略图获取的方案
* 解决IOS Pod Install 后会报错

## 0.2.37
* 更换离线推送Token字符串解析方式(原方式不支持APNS)

## 0.2.38
* 修改 android getConversation 传入非存在sessionId的时候闪退问题

## 0.2.39
* 增加 GroupSystem 节点解析

## 0.2.40
* 增加 TIMProfileSystemElem 节点解析

## 0.2.41
* 修复IOS设备下 deleteConversation 接口无法接收返回值的问题

## 0.2.42
* 修复IOS运行报错

## 0.2.43
* 修复 ValueCallBack 错误码和描述信息反了的问题
* 对登录操作不再做 isEmpty 验证

## 0.2.44
* 优化文本节点隐晦出现BUG的问题

## 1.0.0
* 集成 SDK 5.1.1

## 1.0.1
* 优化Demo

## 1.0.2
* 修复回调调用异常的问题

## 1.0.3
* 修复对象解析错误异常

## 1.0.4
* 修复 getFriendGroups 接口参数为必传的问题

## 1.0.5
* 升级SDK到 5.1.2
* 增加 getGroupOnlineMemberCount 接口

## 1.0.6
* 修复 C2CReadReceipt 回调异常的问题

## 1.1.0
* 优化会话相关接口，提供内部转换
* 增加 getHistoryMessageList 和 markMessageAsRead 接口

## 1.1.1
* 修改混淆文件

## 1.1.2
* 修复 SignalingCommonEntity 实体转换失败的问题

## 1.1.3
* 修复消息发送进度回调数据转换异常的问题

## 1.1.4
* 修复 addFriend 添加好友异常的问题

## 1.1.5
* 修复 MessageRevoked 监听没有参数问题

## 1.1.6
* 增加 GroupTips 数据节点解析

## 1.2.0
* 1. Android 和 IOS 将所有监听器的参数二次转换为 json 取消
* 2. 适配Flutter

## 1.2.1
* 增加 setMessageLocalCustomStr 和 setMessageLocalCustomInt 接口

## 1.2.2
* 修复下载进度出现Optiona的问题

## 1.2.3
* 修复部分回调没有正确接收到参数的问题
* Demo增加生成签名
* 修复部分回调在 IOS 端下包含 Optional 的问题
* 升级SDK版本为 5.1.10

## 1.2.4
* 修复 setMessageLocalCustomStr 执行失败的问题
* Demo增加发起会话
* 修复 onReceiveNewInvitation 解包失败的问题

## 1.2.5
* 修复回调非主线程闪退问题

## 1.2.6
* 修复获得会话传递nextSeq异常的问题

## 1.2.7
* 修复Android端fastjson打包闪退的问题
* DownloadProgress 回调增加 type 属性
* 消息重发接口
* IOS发送消息进度和失败消息的ID未解包的问题
