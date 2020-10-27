//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation
import ImSDK

/// 自定义离线推送数据实体
class CustomOfflinePushInfoEntity: V2TIMOfflinePushInfo {
    required public override init() {
    }

    init(jsonStr: String?) {
        super.init();

        if jsonStr == nil {
            return;
        }

        let dict = JsonUtil.getDictionaryFromJSONString(jsonString: jsonStr!);
        if dict["title"] != nil {
            self.title = (dict["title"] as! String);
        }
        if dict["desc"] != nil {
            self.desc = (dict["desc"] as! String);
        }
        if dict["ext"] != nil {
            self.ext = (dict["ext"] as! String);
        }
        if dict["iOSSound"] != nil {
            self.iOSSound = (dict["iOSSound"] as! String);
        }
        if dict["ignoreIOSBadge"] != nil {
            self.ignoreIOSBadge = (dict["ignoreIOSBadge"] as! Bool);
        }
        if dict["androidOPPOChannelID"] != nil {
            self.androidOPPOChannelID = (dict["androidOPPOChannelID"] as! String);
        }
        if dict["disablePush"] != nil {
            self.disablePush = (dict["disablePush"] as! Bool);
        }
    }
}
