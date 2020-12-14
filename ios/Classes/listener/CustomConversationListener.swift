//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation
import ImSDK

/// 自定义会话监听
class CustomConversationListener: NSObject, V2TIMConversationListener {
    /// 同步服务开始
    func onSyncServerStart() {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.SyncServerStart, params: nil)
    }

    /// 同步服务完成
    func onSyncServerFinish() {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.SyncServerFinish, params: nil)
    }

    /// 同步服务失败
    func onSyncServerFailed() {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.SyncServerFailed, params: nil)
    }

    /// 新会话
    func onNewConversation(_ conversationList: [V2TIMConversation]!) {
        var cs: [[String: Any]] = [];
        for item in conversationList {
            cs.append(CustomConversationEntity.getDict(info: item));
        }
        SwiftTencentImPlugin.invokeListener(type: ListenerType.NewConversation, params: cs)
    }

    /// 会话刷新
    func onConversationChanged(_ conversationList: [V2TIMConversation]!) {
        var cs: [[String: Any]] = [];
        for item in conversationList {
            cs.append(CustomConversationEntity.getDict(info: item));
        }
        SwiftTencentImPlugin.invokeListener(type: ListenerType.ConversationChanged, params: cs)
    }
}
