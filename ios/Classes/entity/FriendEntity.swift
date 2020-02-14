import ImSDK;

//  Created by 蒋具宏 on 2020/2/13.
//  朋友实体
public class FriendEntity : NSObject{
    
    /**
     * ID
     */
    var identifier : String?;
    
    /**
     *  添加来源
     */
    var addSource : String?;
    
    /**
     *  添加时间
     */
    var addTime : UInt64?;
    
    /**
     *  添加说明
     */
    var addWording : String?;
    /**
     *  备注
     */
    var remark : String?;
    /**
     *  用户信息
     */
    var timUserProfile : UserInfoEntity?;
    
    override init() {
    }
    
    init(friend : TIMFriend) {
        super.init();
        self.identifier = friend.identifier;
        self.addSource = friend.addSource;
        self.addTime = friend.addTime;
        self.addWording = friend.addWording;
        self.remark = friend.remark
        self.timUserProfile = UserInfoEntity(userProfile: friend.profile);
    }
}
