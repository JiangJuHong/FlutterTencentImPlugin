//
// Created by 蒋具宏 on 2020/10/29.
//

import Foundation
import ImSDK

/// 自定义用户实体
class CustomUserEntity: V2TIMUserFullInfo {

    convenience init(json: String) {
        self.init(dict: JsonUtil.getDictionaryFromJSONString(jsonString: json))
    }

    init(dict: [String: Any]) {
        super.init();
        self.nickName = (dict["nickName"] as? String);
        self.faceURL = (dict["faceUrl"] as? String);
        self.selfSignature = (dict["selfSignature"] as? String);
        if dict["gender"] != nil {
            self.gender = V2TIMGender.init(rawValue: (dict["gender"] as! Int))!;
        }
        if dict["allowType"] != nil {
            self.allowType = V2TIMFriendAllowType.init(rawValue: (dict["allowType"] as! Int))!;
        }
        self.customInfo = (dict["customInfo"] as? [String: Data]);
    }

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMUserFullInfo) -> [String: Any] {
        var result: [String: Any] = [:];
        result["userID"] = info.userID;
        result["nickName"] = info.nickName;
        result["faceUrl"] = info.faceURL;
        result["selfSignature"] = info.selfSignature;
        result["gender"] = info.gender.rawValue;
        result["allowType"] = info.allowType.rawValue;
        result["customInfo"] = info.customInfo;
        return result;
    }
}
