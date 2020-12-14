//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation
import ImSDK

/// 查找消息实体
class FindMessageEntity: NSObject {

    /// 消息ID
    var msgId: String?;

    required public override init() {
    }

    convenience init(json: String) {
        self.init(dict: JsonUtil.getDictionaryFromJSONString(jsonString: json))
    }

    init(dict: [String: Any]) {
        super.init();
        self.msgId = dict["msgId"] as! String;
    }
}
