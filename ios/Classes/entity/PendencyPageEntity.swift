import ImSDK;

//  Created by 蒋具宏 on 2020/2/14.
//  未决分页列表
public class PendencyPageEntity : NSObject{
    /**
     *  未读数量
     */
    var unreadCnt : UInt64?;
    
    /**
     *  序列号
     */
    var seq : UInt64?;
    
    
    /**
     *  时间戳
     */
    var timestamp : UInt64?;
    
    
    /**
     *  序列号
     */
    var items : [PendencyEntity]?;
    
    override init() {
    }
    
    init(res : TIMFriendPendencyResponse,items : [PendencyEntity]) {
        super.init();
        self.unreadCnt = res.unreadCnt;
        self.seq = res.seq;
        self.timestamp = res.timestamp;
        self.items = items;
    }
}
