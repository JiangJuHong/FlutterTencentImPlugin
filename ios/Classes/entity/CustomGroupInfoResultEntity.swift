//
// Created by 蒋具宏 on 2020/10/29.
//

import Foundation
import ImSDK

/// 自定义群信息结果实体
class CustomGroupInfoResultEntity: V2TIMGroupInfoResult {
    required public override init() {
    }

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMGroupInfoResult) -> [String: Any] {
        var result: [String: Any] = [:];
        result["resultCode"] = info.resultCode;
        result["resultMessage"] = info.resultMsg;
        result["groupInfo"] = CustomGroupInfoEntity.getDict(info: info.info);
        return result;
    }
}
