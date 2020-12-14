//
// Created by 蒋具宏 on 2020/11/4.
//

import Foundation
import ImSDK

/// 自定义群改变信息
class CustomGroupChangeInfoEntity: V2TIMGroupChangeInfo {

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMGroupChangeInfo) -> [String: Any] {
        var result: [String: Any] = [:];
        result["type"] = info.type.rawValue;
        result["key"] = info.key;
        result["value"] = info.value;
        return result;
    }
}
