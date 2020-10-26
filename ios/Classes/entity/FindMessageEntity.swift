//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation
import ImSDK

/// 查找消息实体
class FindMessageEntity: NSObject {

    required public override init() {
    }

    init(json: String) {
        super.init();
        let dict = JsonUtil.getDictionaryFromJSONString(jsonString: json);
    }

    /// 获得消息对象
    open func getMessage() -> V2TIMMessage {
        return V2TIMMessage();
    }
}
