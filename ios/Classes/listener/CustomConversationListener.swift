//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation
import ImSDK

/// 自定义会话监听
class CustomConversationListener: NSObject, V2TIMConversationListener {
    /// 同步服务开始
    func onSyncServerStart() {

    }

    /// 同步服务完成
    func onSyncServerFinish() {

    }

    /// 同步服务失败
    func onSyncServerFailed() {

    }

    /// 新会话
    func onNewConversation(_ conversationList: [V2TIMConversation]!) {

    }

    /// 会话刷新
    func onConversationChanged(_ conversationList: [V2TIMConversation]!) {
        
    }
}
