//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation
import ImSDK

/// 消息相关监听器
class CustomAdvancedMsgListener: NSObject, V2TIMAdvancedMsgListener {
    /// 新消息通知
    func onRecvNewMessage(_ msg: V2TIMMessage!) {

    }

    /// C2C已读回执
    func onRecvC2CReadReceipt(_ receiptList: [V2TIMMessageReceipt]!) {

    }

    /// 消息撤回
    func onRecvMessageRevoked(_ msgID: String!) {

    }
}
