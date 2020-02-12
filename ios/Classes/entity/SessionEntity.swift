import ImSDK

//  Created by 蒋具宏 on 2020/2/10.
//  会话对象
public class SessionEntity : NSObject{
    /**
     * 会话 ID
     */
    var id : String?;
    
    /**
     * 会话名，如果是用户则为用户昵称，如果是群则为群昵称
     */
    var nickname : String?;
    
    /**
     * 会话类型
     */
    var type : SessionType?;
    
    /**
     * 头像(用户头像、群头像、系统头像)
     */
    var faceUrl : String?;
    
    /**
     * 未读消息数量
     */
    var unreadMessageNum : Int32?;
    
    /**
     * 最近一条消息
     */
    var message : MessageEntity?;
    
    /**
     * 群信息，在type为群时有效
     */
    var group : GroupInfoEntity?;
    
    /**
     * 用户信息，在type为C2C时有效
     */
    var userProfile : UserInfoEntity?;
}
