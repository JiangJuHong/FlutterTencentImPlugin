//
// Created by 蒋具宏 on 2020/10/29.
//

import Foundation
import ImSDK

/// 好友操作结果实体
class CustomFriendOperationResultEntity: V2TIMFriendOperationResult {

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMFriendOperationResult) -> [String: Any] {
        var result: [String: Any] = [:];
        result["userID"] = info.userID;
        result["resultCode"] = info.resultCode;
        result["resultInfo"] = info.resultInfo;
        return result;
    }
}
