import ImSDK;

//  Created by 蒋具宏 on 2020/2/15.
//  群未决分页列表
public class GroupPendencyPageEntiity : NSObject{
    var nextStartTimestamp : UInt64?;
    var reportedTimestamp : UInt64?;
    var unReadCount : UInt32?;
    var items : [GroupPendencyEntity]?;
    
    override init() {
    }
    
    init(meta : TIMGroupPendencyMeta,list : [GroupPendencyEntity]) {
        super.init();
        self.nextStartTimestamp = meta.nextStartTime;
        self.reportedTimestamp = meta.readTimeSeq;
        self.unReadCount = meta.unReadCnt;
        self.items = list;
    }
}
