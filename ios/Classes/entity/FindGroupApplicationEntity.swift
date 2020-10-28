//
// Created by 蒋具宏 on 2020/10/28.
//

import Foundation

/// 查找群申请信息实体
class FindGroupApplicationEntity: NSObject {

    required public override init() {
    }

    convenience init(json: String) {
        self.init(dict: JsonUtil.getDictionaryFromJSONString(jsonString: json))
    }

    init(dict: [String: Any]) {
        super.init();
    }
}
