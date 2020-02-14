import ImSDK;

//  Created by 蒋具宏 on 2020/2/14.
//  未决类型枚举
public enum PendencyTypeEnum : Int{
    /**
     *  别人发给我的未决请求
     */
    case COME_IN = 1
    
    /**
     *  我发给别人的未决请求
     */
    case SEND_OUT = 2
    
    /**
     *  别人发给我的以及我发给别人的所有未决请求，仅在拉取时有效。
     */
    case BOTH = 3
    
    /**
     * 根据腾讯云获得枚举
     */
    static func getByTIMPendencyType(type : TIMPendencyType)->PendencyTypeEnum{
        return (PendencyTypeEnum(rawValue: type.rawValue) ?? nil)!;
    }
}
