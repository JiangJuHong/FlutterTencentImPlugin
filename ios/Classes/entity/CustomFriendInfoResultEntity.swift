//
// Created by 蒋具宏 on 2020/11/3.
//

import Foundation
import ImSDK

class CustomFriendInfoResultEntity: V2TIMFriendInfoResult {

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMFriendInfoResult) -> [String: Any] {
        var result: [String: Any] = [:];
        result["resultCode"] = info.resultCode;
        result["resultInfo"] = info.resultInfo;
        result["relation"] = info.relation.rawValue;
        result["friendInfo"] = CustomFriendInfoEntity.getDict(info: info.friendInfo);
        return result;
    }
}
