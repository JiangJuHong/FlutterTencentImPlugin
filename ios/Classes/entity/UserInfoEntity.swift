import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  用户信息实体
public class UserInfoEntity : NSObject{
    /**
     * 生日
     */
    var birthday : UInt32?;
    
    /**
     * ID
     */
    var identifier : String?;
    
    /**
     * 角色
     */
    var role : UInt32?;
    
    /**
     * 性别
     */
    var gender : Int?;
    
    /**
     * 等级
     */
    var level : UInt32?;
    
    /**
     * 昵称
     */
    var nickName : String?;
    
    /**
     * 语言
     */
    var language : UInt32?;
    
    /**
     * 自定义字段
     */
    var customInfo : [AnyHashable : Any]?;
    
    /**
     * 签名
     */
    var selfSignature : Data?;
    
    /**
     * 加好友类型
     */
    var allowType : UserAllowType?;
    
    /**
     * 头像
     */
    var faceUrl : String?;
    
    /**
     * 区域
     */
    var location : Data?;
    
    override init() {
    }
    
    init(userProfile : TIMUserProfile) {
        super.init();
        self.birthday = userProfile.birthday;
        self.identifier = userProfile.identifier;
        self.role = userProfile.role;
        self.gender = userProfile.gender.hashValue;
        self.level = userProfile.level;
        self.nickName = userProfile.nickname;
        self.language = userProfile.language;
        self.customInfo = userProfile.customInfo;
        self.selfSignature = userProfile.selfSignature;
        self.allowType = UserAllowType.getByTIMFriendAllowType(type: userProfile.allowType);
        self.faceUrl = userProfile.faceURL;
        self.location = userProfile.location;
    }
}
