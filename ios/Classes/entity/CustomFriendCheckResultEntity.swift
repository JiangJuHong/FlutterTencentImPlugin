//
// Created by 蒋具宏 on 2020/11/3.
//

import Foundation
import ImSDK

/// 自定义好友检查结果实体
class CustomFriendCheckResultEntity : V2TIMFriendCheckResult{

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMFriendCheckResult) -> [String: Any] {
        var result: [String: Any] = [:];
        result["userID"] = info.userID;
        result["resultCode"] = info.resultCode;
        result["resultInfo"] = info.resultInfo;
        result["resultType"] = info.relationType.rawValue;
        return result;
    }
}
