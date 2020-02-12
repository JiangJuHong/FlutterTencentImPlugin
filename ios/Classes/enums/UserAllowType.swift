import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  用户允许类型
public enum UserAllowType : Int{
    case AllowType_Type_AllowAny = 0
    case AllowType_Type_NeedConfirm = 1
    case AllowType_Type_DenyAny = 2
    
    /**
     * 根据腾讯云获得枚举
     */
    static func getByTIMFriendAllowType(type : TIMFriendAllowType)->UserAllowType{
        return (UserAllowType(rawValue: type.rawValue) ?? nil)!;
    }
}
