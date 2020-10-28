//
// Created by 蒋具宏 on 2020/10/29.
//

import Foundation
import ImSDK

/// 自定义群成员操作结果
class CustomGroupMemberOperationResultEntity: V2TIMGroupMemberOperationResult {

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMGroupMemberOperationResult) -> [String: Any] {
        var result: [String: Any] = [:];
        result["result"] = info.result.rawValue;
        result["memberID"] = info.userID;
        return result;
    }
}
