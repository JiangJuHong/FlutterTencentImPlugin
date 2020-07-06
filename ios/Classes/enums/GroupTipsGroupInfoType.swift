import  ImSDK;

//  Created by 蒋具宏 on 2020/2/15.
//
public enum GroupTipsGroupInfoType : Int{
    case Invalid = 0
    case ModifyName = 1
    case ModifyIntroduction = 2
    case ModifyNotification = 4
    case ModifyFaceUrl = 8
    case ModifyOwner = 16
    case ModifyCustom = 32
    
    /**
     * 根据腾讯云获得枚举
     */
    static func getByTIM_GROUP_INFO_CHANGE_TYPE(type : TIM_GROUP_INFO_CHANGE_TYPE)->GroupTipsGroupInfoType?{
        return (GroupTipsGroupInfoType(rawValue: type.rawValue) ?? nil);
    }
}
