//
// Created by 蒋具宏 on 2020/11/3.
//

import Foundation
import ImSDK

/// 自定义好友分组实体
class CustomFriendGroupEntity: V2TIMFriendGroup {

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMFriendGroup) -> [String: Any] {
        var result: [String: Any] = [:];
        result["name"] = info.groupName;
        result["friendCount"] = info.userCount;
        result["friendIDList"] = info.friendList;
        return result;
    }
}
