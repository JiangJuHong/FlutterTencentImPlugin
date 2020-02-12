import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  会话类型
public enum SessionType : Int {
    case C2C = 1
    case Group = 2
    case System = 3;
    
    /**
     * 根据腾讯云获得枚举
     */
    static func getByTIMConversationType(type : TIMConversationType)->SessionType{
        return (SessionType(rawValue: type.rawValue) ?? nil)!;
    }
}
