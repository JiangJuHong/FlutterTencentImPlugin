# 3.0升级文档
## 通用变化
* 将 `setReceiveMessageOpt` 替换为 `setGroupReceiveMessageOpt`
* 将 `GroupReceiveMessageOptEnum` 替换为 `ReceiveMessageOptEnum`
* `MessageStatusEnum` 增加 Imported 属性

## 新增内容
* 新增 ``setGroupReceiveMessageOpt`` 设置群接收消息选项接口
* 新增 ``setC2CReceiveMessageOpt`` 设置C2C接收消息选项接口
* 新增 ``ReceiveMessageOptEnum`` 接收消息选项枚举类
* 新增 ``pinConversation`` 置顶会话接口
* 新增 ``getTotalUnreadMessageCount`` 获得会话总未读数接口
* 新增 ``conversation`` 增加 ``pinned`` 会话是否置顶属性

## 移除内容
* 移除 ``setReceiveMessageOpt`` 接口
* 移除 ``GroupReceiveMessageOptEnum`` 枚举