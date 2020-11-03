//
// Created by 蒋具宏 on 2020/11/3.
//

import Foundation
import ImSDK

/// 自定义消息响应实体
class CustomMessageReceiptEntity: V2TIMMessageReceipt {

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMMessageReceipt) -> [String: Any] {
        var result: [String: Any] = [:];
        result["userID"] = info.userID;
        result["timestamp"] = info.timestamp;
        return result;
    }
}
