import ImSDK

//  Created by 蒋具宏 on 2020/2/15.
//  未决请求类型
public enum GroupPendencyGetType : Int{
    case APPLY_BY_SELF = 0
    case INVITED_BY_OTHER = 1
    case BOTH_SELFAPPLY_AND_INVITED = 2
    
    /**
     * 根据腾讯云获得枚举
     */
    static func getByTIMGroupPendencyGetType(type : TIMGroupPendencyGetType)->GroupPendencyGetType{
        return (GroupPendencyGetType(rawValue: type.rawValue) ?? nil)!;
    }
}
