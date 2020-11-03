//
// Created by 蒋具宏 on 2020/11/3.
//

import Foundation
import ImSDK

/// 好友申请结果实体
class CustomFriendApplicationResultEntity: V2TIMFriendApplicationResult {

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMFriendApplicationResult) -> [String: Any] {
        var result: [String: Any] = [:];
        result["unreadCount"] = info.unreadCount;

        var friendApplicationList: [[String: Any]] = [];
        for item in info.applicationList {
            friendApplicationList.append(CustomFriendApplicationEntity.getDict(info: item as! V2TIMFriendApplication))
        }
        result["friendApplicationList"] = friendApplicationList;
        return result;
    }
}
