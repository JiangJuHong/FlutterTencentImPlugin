import ImSDK

//  Created by 蒋具宏 on 2020/2/15.
//  消息撤回通知实体
public class MessageLocatorEntity : NSObject{
    var timestamp : time_t?;
    var seq  : UInt64?;
    var rand  : UInt64?;
    var isSelf : Bool?;
    var stype : SessionType?;
    var sid : String?;
    var isRevokedMsg : Bool?;
    
    
    override init() {
    }
    
    init(locator : TIMMessageLocator) {
        super.init();
        self.timestamp = locator.time;
        self.seq = locator.seq;
        self.rand = locator.rand;
        self.isSelf = locator.isSelf;
        self.stype = SessionType.getByTIMConversationType(type: locator.sessType);
        self.sid = locator.sessId;
        self.isRevokedMsg = locator.isFromRevokeNotify;
    }
}
