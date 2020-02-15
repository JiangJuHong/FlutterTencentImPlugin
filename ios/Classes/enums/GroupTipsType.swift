import ImSDK

//  Created by 蒋具宏 on 2020/2/15.
//  群提示类型
public enum GroupTipsType : Int{
    case Invalid = 0
    case Join = 1
    case Quit = 2
    case Kick = 3
    case SetAdmin = 4
    case CancelAdmin = 5
    case ModifyGroupInfo = 6
    case ModifyMemberInfo = 7
    case AaddGroup = 8
    case DelGroup = 9
    
    /**
     * 根据腾讯云获得枚举
     */
    static func getByTIM_GROUP_TIPS_TYPE(type : TIM_GROUP_TIPS_TYPE)->GroupTipsType{
        return (GroupTipsType(rawValue: type.rawValue) ?? nil)!;
    }
}
