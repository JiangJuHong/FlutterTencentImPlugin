import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  用户允许入群类型
public enum GroupAddOptType : Int,CaseIterable{
    case TIM_GROUP_ADD_FORBID = 0
    case TIM_GROUP_ADD_AUTH = 1
    case TIM_GROUP_ADD_ANY = 2
    
    /**
     * 根据腾讯云获得枚举
     */
    static func getByTIMGroupAddOpt(type : TIMGroupAddOpt)->GroupAddOptType{
        return (GroupAddOptType(rawValue: type.rawValue) ?? nil)!;
    }
    
    /**
     * 根据名称获得枚举
     */
    static func getEnumByName(name : String)->GroupAddOptType?{
        for item in GroupAddOptType.allCases{
            if "\(item)" == name{
                return item;
            }
        }
        return nil;
    }
}
