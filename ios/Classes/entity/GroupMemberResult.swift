import ImSDK

//  Created by 蒋具宏 on 2020/2/14.
//  群成员结实体
public class GroupMemberResult :NSObject{
    
    /**
     *  用户ID
     */
    var user : String?;
    
    /**
     *  结果
     */
    var result : Int?;
    
    override init() {
    }
    
    init(result : TIMGroupMemberResult) {
        super.init();
        self.user = result.member;
        self.result = result.status.rawValue;
    }
}
