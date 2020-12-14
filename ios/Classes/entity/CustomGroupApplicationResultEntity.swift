//
// Created by 蒋具宏 on 2020/10/29.
//

import Foundation
import ImSDK

/// 群申请结果实体
class CustomGroupApplicationResultEntity: V2TIMGroupApplicationResult {

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMGroupApplicationResult) -> [String: Any] {
        var result: [String: Any] = [:];
        result["unreadCount"] = info.unreadCount;
        var groupApplicationList: [[String: Any]] = [];
        for item in info.applicationList! {
            groupApplicationList.append(CustomGroupApplicationEntity.getDict(info: item as! V2TIMGroupApplication))
        }
        result["groupApplicationList"] = groupApplicationList;
        return result;
    }
}
