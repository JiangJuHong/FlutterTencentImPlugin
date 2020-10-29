//
// Created by 蒋具宏 on 2020/10/29.
//

import Foundation
import ImSDK

/// 自定义好友信息实体
class CustomFriendInfoEntity: V2TIMFriendInfo {

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMFriendInfo) -> [String: Any] {
        var result: [String: Any] = [:];
        result["userID"] = info.userID;
        result["friendRemark"] = info.friendRemark;
        result["friendGroups"] = info.friendGroups;
        result["friendCustomInfo"] = info.friendCustomInfo;
        result["userProfile"] = CustomUserEntity.getDict(info: info.userFullInfo);
        return result;
    }
}
