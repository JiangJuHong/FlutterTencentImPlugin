//
// Created by 蒋具宏 on 2020/10/29.
//

import Foundation
import ImSDK_Plus

/// 自定义好友信息实体
class CustomFriendInfoEntity: V2TIMFriendInfo {

    convenience init(json: String) {
        self.init(dict: JsonUtil.getDictionaryFromJSONString(jsonString: json))
    }

    init(dict: [String: Any]) {
        super.init();
        self.userID = (dict["userID"] as? String);
        self.friendRemark = (dict["friendRemark"] as? String);
        if dict["friendCustomInfo"] != nil {
            self.friendCustomInfo = [:];
            for (k, v) in (dict["friendCustomInfo"] as! [String: String]) {
                self.friendCustomInfo[k] = v.data(using: .utf8)
            }
        }
    }

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
