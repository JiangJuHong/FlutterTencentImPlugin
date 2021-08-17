//
// Created by 蒋具宏 on 2020/11/4.
//

import Foundation
import ImSDK_Plus

/// 自定义群信息实体
class CustomGroupMemberChangeInfoEntity: V2TIMGroupMemberChangeInfo {

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMGroupMemberChangeInfo) -> [String: Any] {
        var result: [String: Any] = [:];
        result["userID"] = info.userID;
        result["muteTime"] = info.muteTime;
        return result;
    }
}
