//
// Created by 蒋具宏 on 2020/10/29.
//

import Foundation
import ImSDK

/// 自定义群信息实体
class CustomGroupInfoEntity: V2TIMGroupInfo {

    required public override init() {
    }

    convenience init(json: String) {
        self.init(dict: JsonUtil.getDictionaryFromJSONString(jsonString: json))
    }

    init(dict: [String: Any]) {
        super.init();
        self.groupID = (dict["groupID"] as? String);
        self.groupType = (dict["groupType"] as? String);
        self.groupName = (dict["groupName"] as? String);
        self.notification = (dict["notification"] as? String);
        self.introduction = (dict["introduction"] as? String);
        self.faceURL = (dict["faceUrl"] as? String);
        if dict["allMuted"] != nil {
            self.allMuted = (dict["allMuted"] as! Bool);
        }
        if dict["groupAddOpt"] != nil {
            self.groupAddOpt = V2TIMGroupAddOpt.init(rawValue: (dict["groupAddOpt"] as! Int))!;
        }
        self.customInfo = (dict["customInfo"] as? [String: Data]);
    }

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMGroupInfo) -> [String: Any] {
        var result: [String: Any] = [:];
        result["groupID"] = info.groupID;
        result["groupType"] = info.groupType;
        result["groupName"] = info.groupName;
        result["notification"] = info.notification;
        result["introduction"] = info.introduction;
        result["faceUrl"] = info.faceURL;
        result["allMuted"] = info.allMuted;
        result["owner"] = info.owner;
        result["createTime"] = info.createTime;
        result["groupAddOpt"] = info.groupAddOpt.rawValue;
        result["lastInfoTime"] = info.lastInfoTime;
        result["lastMessageTime"] = info.lastMessageTime;
        result["memberCount"] = info.memberCount;
        result["onlineCount"] = info.onlineCount;
        result["role"] = info.role.rawValue;
        result["recvOpt"] = info.recvOpt.rawValue;
        result["joinTime"] = info.joinTime;
        result["customInfo"] = info.customInfo;
        return result;
    }
}