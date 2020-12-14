//
// Created by 蒋具宏 on 2020/11/3.
//

import Foundation
import ImSDK

/// 好友申请实体
class CustomFriendAddApplicationEntity: V2TIMFriendAddApplication {
    convenience init(json: String) {
        self.init(dict: JsonUtil.getDictionaryFromJSONString(jsonString: json))
    }

    init(dict: [String: Any]) {
        super.init();
        self.userID = (dict["userID"] as? String);
        self.friendRemark = (dict["friendRemark"] as? String);
        self.addWording = (dict["addWording"] as? String);
        self.addSource = (dict["addSource"] as? String);
        if dict["addType"] != nil {
            self.addType = V2TIMFriendType.init(rawValue: (dict["addType"] as! Int))!
        }
    }
}
