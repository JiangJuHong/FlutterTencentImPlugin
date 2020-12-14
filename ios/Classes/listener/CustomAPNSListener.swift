//
// Created by 蒋具宏 on 2020/10/29.
//

import Foundation
import ImSDK

/// 自定义APNS监听器
class CustomAPNSListener: NSObject, V2TIMAPNSListener {
    public static var number: UInt32 = 0;


    /// 程序进后台后，自定义 APP 的未读数，如果不处理，APP 未读数默认为所有会话未读数之和
    func onSetAPPUnreadCount() -> UInt32 {
        return CustomAPNSListener.number;
    }
}
