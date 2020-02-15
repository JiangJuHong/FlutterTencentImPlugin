import ImSDK;
import HandyJSON

//  Created by 蒋具宏 on 2020/2/14.
//  群成员实体
public class GroupMemberEntity : NSObject,HandyJSON{
    var role : Int?;
    var silenceSeconds : UInt32?
    var joinTime : time_t?;
    var nameCard : String?;
    var user : String?;
    var userProfile : UserInfoEntity?;
    
    required public override init() {
     }
    
    init(info : TIMGroupMemberInfo) {
        super.init();
        self.role = info.role.rawValue;
        self.silenceSeconds = info.silentUntil;
        self.joinTime = info.joinTime;
        self.nameCard = info.nameCard;
        self.user = info.member;
    }
}
