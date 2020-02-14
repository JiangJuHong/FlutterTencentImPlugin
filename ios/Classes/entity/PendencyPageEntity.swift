import ImSDK;

//  Created by 蒋具宏 on 2020/2/14.
//  未决分页列表
public class PendencyPageEntity : NSObject{
    /**
     *  未读数量
     */
    var unreadCnt : Int32?;
    
    /**
     *  序列号
     */
    var seq : Int32?;
    
    
    /**
     *  时间戳
     */
    var timestamp : Int32?;
    
    
    /**
     *  序列号
     */
    var items : [PendencyEntity]?;
}
