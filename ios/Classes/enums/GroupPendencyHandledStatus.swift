import ImSDK;

//  Created by 蒋具宏 on 2020/2/15.
//  群未决处理状态
public enum GroupPendencyHandledStatus : Int{
    case NOT_HANDLED = 0
    case HANDLED_BY_OTHER = 1
    case HANDLED_BY_SELF = 2
    
    /**
     * 根据腾讯云获得枚举
     */
    static func getByGroupPendencyHandledStatus(status : TIMGroupPendencyHandleStatus)->GroupPendencyHandledStatus{
        return (GroupPendencyHandledStatus(rawValue: status.rawValue) ?? nil)!;
    }
}
