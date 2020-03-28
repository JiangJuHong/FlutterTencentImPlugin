//  Created by 蒋具宏 on 2020/2/12.
//  关系链变更类型
public enum SnsTipsType : Int{
    /// 未知
    case INVALID = 0
    /// 增加好友消息 
    case ADD_FRIEND = 1
    /// 删除好友 
    case DEL_FRIEND = 2
    /// 增加好友申请 
    case ADD_FRIEND_REQ = 3
    /// 删除好友申请 
    case DEL_FRIEND_REQ = 4
    /// 添加黑名单 
    case ADD_BLACKLIST = 5
    /// 删除黑名单 
    case DEL_BLACKLIST = 6
    /// 未决已读上报 
    case PENDENCY_REPORT = 7
    /// 关系链资料变更 
    case SNS_PROFILE_CHANGE = 8
    /// 推荐数据增加 
    case ADD_RECOMMEND = 9
    /// 推荐数据减少 
    case DEL_RECOMMEND = 10
    /// 已决增加 
    case ADD_DECIDE = 11
    /// 已决减少 
    case DEL_DECIDE = 12
    /// 推荐已读上报 
    case RECOMMEND_REPORT = 13
    /// 已决已读上报 
    case DECIDE_REPORT = 14
}
