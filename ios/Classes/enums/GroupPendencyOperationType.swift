import ImSDK;

//  Created by 蒋具宏 on 2020/2/15.
//  群未决操作类型
public enum GroupPendencyOperationType : Int{
    case REFUSE = 0
    case ACCEPT = 1
    
    /**
     * 根据腾讯云获得枚举
     */
    static func getByTIMGroupPendencyHandleResult(type : TIMGroupPendencyHandleResult)->GroupPendencyOperationType{
        return (GroupPendencyOperationType(rawValue: type.rawValue) ?? nil)!;
    }
}
