//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation
import ImSDK

/// 消息相关监听器
class CustomAdvancedMsgListener: NSObject, V2TIMAdvancedMsgListener {
    /// 新消息通知
    func onRecvNewMessage(_ msg: V2TIMMessage!) {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.NewMessage, params: MessageEntity.init(message: msg!))
    }

    /// C2C已读回执
    func onRecvC2CReadReceipt(_ receiptList: [V2TIMMessageReceipt]!) {
        var data: [[String: Any]] = [];
        for item in receiptList {
            data.append(CustomMessageReceiptEntity.getDict(info: item));
        }
        SwiftTencentImPlugin.invokeListener(type: ListenerType.C2CReadReceipt, params: data)
    }

    /// 消息撤回
    func onRecvMessageRevoked(_ msgID: String!) {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.MessageRevoked, params: msgID)
    }
}
