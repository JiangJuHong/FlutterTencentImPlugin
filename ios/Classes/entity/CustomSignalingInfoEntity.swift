//
// Created by 蒋具宏 on 2020/11/6.
//

import Foundation
import ImSDK

/// 自定义信令信息实体
class CustomSignalingInfoEntity: V2TIMSignalingInfo {
    required public override init() {
    }

    init(jsonStr: String?) {
        super.init();

        if jsonStr == nil {
            return;
        }
        let dict = JsonUtil.getDictionaryFromJSONString(jsonString: jsonStr!);
        self.inviteID = (dict["inviteID"] as? String);
        self.groupID = (dict["groupID"] as? String);
        self.inviter = (dict["inviter"] as? String);
        self.inviteeList = (dict["inviteeList"] as? NSMutableArray);
        self.data = (dict["data"] as? String);
        if dict["timeout"] != nil {
            self.timeout = (dict["timeout"] as! UInt32);
        }
        if dict["actionType"] != nil {
            self.actionType = SignalingActionType.init(rawValue: (dict["actionType"] as! Int))!;
        }
    }

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMSignalingInfo) -> [String: Any] {
        var result: [String: Any] = [:];
        result["inviteID"] = info.inviteID;
        result["groupID"] = info.groupID;
        result["inviter"] = info.inviter;
        result["inviteeList"] = info.inviteeList;
        result["data"] = info.data;
        result["timeout"] = info.timeout;
        result["actionType"] = info.actionType.rawValue;
        return result;
    }
}
