import ImSDK;

//  Created by 蒋具宏 on 2020/2/14.
//  好友分组实体
public class FriendGroupEntity : NSObject{
    /**
     * 组名
     */
    var name : String?;
    
    /**
     * 用户数量
     */
    var userCnt : UInt64?;
    
    /**
     * 朋友ID集合
     */
    var friends : [Any]?;
    
    required public override init() {
     }
    
    init(group : TIMFriendGroup) {
        super.init();
        self.name = group.name;
        self.userCnt = group.userCnt;
        self.friends = group.friends;
    }
}
