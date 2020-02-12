import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  消息状态
public enum MessageStatus : Int{
    case Sending = 1
    case SendSucc = 2
    case SendFail = 3
    case HasDeleted = 4
    case HasRevoked = 6
    
    /**
     * 根据腾讯云获得枚举
     */
    static func getByTIMMessageStatus(status : TIMMessageStatus)->MessageStatus{
        return (MessageStatus(rawValue: status.rawValue) ?? nil)!;
    }
}
