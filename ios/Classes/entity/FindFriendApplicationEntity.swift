//
// Created by 蒋具宏 on 2020/11/3.
//

import Foundation

/// 查找好友申请实体
class FindFriendApplicationEntity: NSObject {

    required public override init() {
    }

    convenience init(json: String) {
        self.init(dict: JsonUtil.getDictionaryFromJSONString(jsonString: json))
    }

    init(dict: [String: Any]) {
        super.init();
    }
}
