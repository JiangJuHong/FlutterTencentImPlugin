//
// Created by 蒋具宏 on 2020/11/3.
//

import Foundation

/// 查找好友申请实体
class FindFriendApplicationEntity: NSObject {

    /// 用户ID
    var userID: String?;

    /// 类型
    var type: Int?;

    required public override init() {
    }

    convenience init(json: String) {
        self.init(dict: JsonUtil.getDictionaryFromJSONString(jsonString: json))
    }

    init(dict: [String: Any]) {
        super.init();
        self.userID = dict["userID"] as! String;
        self.type = dict["type"] as! Int;
    }
}
