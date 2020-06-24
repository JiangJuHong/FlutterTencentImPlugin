import ImSDK;

//  Created by 蒋具宏 on 2020/2/15.
//  群未决实体
public class GroupPendencyEntity : NSObject{
    /**
     * 来自(请求人/邀请人)
     */
    var fromUser : String?;
    /**
     * 群ID
     */
    var groupId : String?;
    /**
     * 处理者添加的附加信息
     */
    var handledMsg : String?;
    /**
     * 处理状态
     */
    var handledStatus : GroupPendencyHandledStatus?;

    /**
     * 申请人ID
     */
    var identifier : String?;

    /**
     * 增加时间
     */
    var addTime : UInt64?;

    /**
     * 操作类型
     */
    var operationType : GroupPendencyOperationType?;

    /**
     * 请求类型
     */
    var pendencyType : GroupPendencyGetType?;

    /**
     * 请求附加信息
     */
    var requestMsg : String?;

    /**
     * 处理者ID
     */
    var toUser : String?;

    /**
     * 申请人信息
     */
    var applyUserInfo : UserInfoEntity?;

    /**
     * 处理人信息
     */
    var handlerUserInfo : UserInfoEntity?;

    /**
     * 群信息
     */
    var groupInfo : GroupInfoEntity?;
    
    override init() {
    }
    
    init(item : TIMGroupPendencyItem) {
        super.init();
        self.handledStatus = GroupPendencyHandledStatus.getByGroupPendencyHandledStatus(status: item.handleStatus);
        self.operationType = GroupPendencyOperationType.getByTIMGroupPendencyHandleResult(type: item.handleResult);
        self.pendencyType = GroupPendencyGetType.getByTIMGroupPendencyGetType(type: item.getType);
        self.fromUser = item.fromUser;
        self.groupId = item.groupId;
        self.handledMsg = item.handledMsg;
        self.identifier = item.selfIdentifier;
        self.addTime = item.addTime;
        self.requestMsg = item.requestMsg;
        self.toUser = item.toUser;
    }
}
