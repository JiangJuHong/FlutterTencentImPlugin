import ImSDK

//  Created by 蒋具宏 on 2020/2/14.
//  添加好友返回对象
public class FriendResultEntity : NSObject{
    var identifier : String?;
    var resultCode : Int?;
    var resultInfo : String?;
    
    override init() {
    }
    
    init(result : TIMFriendResult) {
        super.init();
        self.identifier = result.identifier;
        self.resultCode = result.result_code;
        self.resultInfo = result.result_info;
    }
}
