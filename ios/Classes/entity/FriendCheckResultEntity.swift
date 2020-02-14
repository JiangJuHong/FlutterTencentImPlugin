import ImSDK

//  Created by 蒋具宏 on 2020/2/14.
//  好友关系检测返回对象
public class FriendCheckResultEntity : NSObject{
    var identifier : String?;
    var resultCode : Int?;
    var resultInfo : String?;
    var resultType : Int?;
    
    override init() {
    }
    
    init(result : TIMCheckFriendResult) {
        super.init();
        self.identifier = result.identifier;
        self.resultCode = result.result_code;
        self.resultInfo = result.result_info;
        self.resultType = result.resultType.rawValue;
    }
}
