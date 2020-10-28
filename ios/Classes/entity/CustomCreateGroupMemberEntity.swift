//
// Created by 蒋具宏 on 2020/10/29.
//

import Foundation
import ImSDK

/// 自定义群创建群成员实体
class CustomCreateGroupMemberEntity: V2TIMCreateGroupMemberInfo {
    required public override init() {
    }

    convenience init(json: String) {
        self.init(dict: JsonUtil.getDictionaryFromJSONString(jsonString: json))
    }

    init(dict: [String: Any]) {
        super.init();
        self.userID = (dict["userID"] as? String);
        if dict["role"] != nil {
            self.role = V2TIMGroupMemberRole.init(rawValue: (dict["role"] as! Int))!;
        }
    }
}
