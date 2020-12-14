//
// Created by 蒋具宏 on 2020/10/29.
//

import Foundation
import ImSDK

/// 自定义群申请实体
class CustomGroupApplicationEntity: V2TIMGroupApplication {

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMGroupApplication) -> [String: Any] {
        var result: [String: Any] = [:];
        result["groupID"] = info.groupID;
        result["fromUser"] = info.fromUser;
        result["fromUserNickName"] = info.fromUserNickName;
        result["fromUserFaceUrl"] = info.fromUserFaceUrl;
        result["toUser"] = info.toUser;
        result["addTime"] = info.addTime;
        result["requestMsg"] = info.requestMsg;
        result["handledMsg"] = info.handledMsg;
        result["type"] = info.getType.rawValue;
        result["handleStatus"] = info.handleStatus.rawValue;
        result["handleResult"] = info.handleResult.rawValue;
        return result;
    }
}
