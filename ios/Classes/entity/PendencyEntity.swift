import ImSDK

//  Created by 蒋具宏 on 2020/2/14.
//  未决对象实体
public class PendencyEntity : NSObject{
    var identifier : String?;
    var addSource : String?;
    var addTime : UInt64?;
    var addWording : String?;
    var nickname : String?;
    var type : PendencyTypeEnum?;
    var userProfile : UserInfoEntity?;
    
    override init() {
    }
    
    init(item : TIMFriendPendencyItem) {
        super.init();
        self.identifier = item.identifier;
        self.addSource = item.addSource;
        self.addTime = item.addTime;
        self.addWording = item.addWording;
        self.nickname = item.nickname;
        self.type = PendencyTypeEnum.getByTIMPendencyType(type: item.type);
    }
}
