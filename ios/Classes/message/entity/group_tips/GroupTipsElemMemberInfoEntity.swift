import ImSDK;

//  Created by 蒋具宏 on 2020/2/15.
// 群通知节点成员信息实体
public class GroupTipsElemMemberInfoEntity : NSObject{
    var identifier : String?;
    var shutupTime : UInt32?;
    
    required public override init() {
     }
    
    init(info : TIMGroupTipsElemMemberInfo) {
        super.init();
        self.identifier = info.identifier;
        self.shutupTime = info.shutupTime;
    }
}
