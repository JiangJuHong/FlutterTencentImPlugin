import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  群信息实体
public class GroupInfoEntity : NSObject{
    
    /**
     * 类型
     */
    var groupType : String?;
    
    /**
     * 最大成员数量
     */
    var maxMemberNum : UInt32?;
    
    /**
     * 群主ID
     */
    var groupOwner : String?;
    
    /**
     * 自定义字段
     */
    var custom : [String : Data]?;
    
    /**
     * 群ID
     */
    var groupId : String?;
    
    /**
     * 返回码
     */
    var resultCode : Int32?;
    
    /**
     * 群通知
     */
    var groupNotification : String?;
    
    /**
     * 群成员数
     */
    var memberNum : UInt32?;
    
    /**
     * 返回结果
     */
    var resultInfo : String?;
    
    /**
     *  群头像
     */
    var faceUrl : String?;
    
    /**
     *  群名
     */
    var groupName : String?;
    
    /**
     * 加群选项
     */
    var addOption : GroupAddOptType?;
    
    /**
     * 创建时间
     */
    var createTime : UInt32?;
    
    /**
     * 群简介
     */
    var groupIntroduction : String?;
    
    /**
     * 是否禁言所有人
     */
    var silenceAll : Bool?;
    
    /**
     * 最后一次发消息时间
     */
    var lastMsgTime : UInt32?;
    
    /**
     * 在线成员数量
     */
    var onlineMemberNum : UInt32?;
    
    /**
     * 最后一次修改群资料时间
     */
    var lastInfoTime : UInt32?;
    
    override init() {
    }
    
    init(groupInfo : TIMGroupInfoResult) {
        super.init();
        self.groupOwner = groupInfo.owner;
        self.groupType = groupInfo.groupType;
        self.maxMemberNum = groupInfo.maxMemberNum;
        self.custom = groupInfo.customInfo;
        self.groupId = groupInfo.group;
        self.resultCode = groupInfo.resultCode;
        self.groupNotification = groupInfo.notification;
        self.memberNum = groupInfo.memberNum;
        self.resultInfo = groupInfo.resultInfo;
        self.faceUrl = groupInfo.faceURL;
        self.groupName = groupInfo.groupName;
        self.addOption = GroupAddOptType.getByTIMGroupAddOpt(type: groupInfo.addOpt);
        self.createTime = groupInfo.createTime;
        self.groupIntroduction = groupInfo.introduction;
        self.silenceAll = groupInfo.allShutup;
        self.lastMsgTime = groupInfo.lastMsgTime;
        self.onlineMemberNum = groupInfo.onlineMemberNum;
        self.lastInfoTime = groupInfo.lastInfoTime;
    }
}
