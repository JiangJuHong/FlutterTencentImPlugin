//
// Created by 蒋具宏 on 2020/10/29.
//

import Foundation
import ImSDK_Plus

/// 自定义用户实体
class CustomUserEntity: V2TIMUserFullInfo {

    convenience init(json: String) {
        self.init(dict: JsonUtil.getDictionaryFromJSONString(jsonString: json))
    }

    init(dict: [String: Any]) {
        super.init();
        if dict["nickName"] != nil{
            self.nickName = (dict["nickName"] as? String);
        }
        if dict["faceURL"] != nil{
            self.faceURL = (dict["faceURL"] as? String);
        }
        if dict["selfSignature"] != nil{
            self.selfSignature = (dict["selfSignature"] as? String);
        }
        if dict["gender"] != nil {
            self.gender = V2TIMGender.init(rawValue: (dict["gender"] as! Int))!;
        }
        if dict["role"] != nil {
            self.role = (dict["role"] as! UInt32);
        }
        if dict["level"] != nil {
            self.level = (dict["level"] as! UInt32);
        }
        if dict["birthday"] != nil {
            self.birthday = (dict["birthday"] as! UInt32);
        }
        if dict["allowType"] != nil {
            self.allowType = V2TIMFriendAllowType.init(rawValue: (dict["allowType"] as! Int))!;
        }
        if dict["customInfo"] != nil {
            self.customInfo = [:];
            for (k, v) in (dict["customInfo"] as! [String: String]) {
                self.customInfo[k] = v.data(using: .utf8)
            }
        }
    }

    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMUserFullInfo) -> [String: Any] {
        var result: [String: Any] = [:];
        result["userID"] = info.userID;
        result["nickName"] = info.nickName;
        result["faceUrl"] = info.faceURL;
        result["selfSignature"] = info.selfSignature;
        result["gender"] = info.gender.rawValue;
        result["role"] = info.role;
        result["level"] = info.level;
        result["birthday"] = info.birthday;
        result["allowType"] = info.allowType.rawValue;
        result["customInfo"] = info.customInfo;
        return result;
    }
}
