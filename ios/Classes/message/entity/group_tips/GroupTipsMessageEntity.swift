import ImSDK

//
//  GroupTipsMessageself.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/21.
//  群体是消息实体
public class GroupTipsMessageEntity: AbstractMessageEntity {
    /// 群ID
    var groupID: String?;

    /// 操作类型
    var type: Int?;

    /// 操作者
    var opMember: [String: Any]?;

    /// 被操作人列表
    var memberList: [[String: Any]]?;

    /// 群资料变更信息列表，仅当tipsType值为V2TIMGroupTipsElem#V2TIM_GROUP_TIPS_TYPE_GROUP_INFO_CHANGE时有效
    var groupChangeInfoList: [[String: Any]]?;

    /// 群成员变更信息列表，仅当tipsType值为V2TIMGroupTipsElem#V2TIM_GROUP_TIPS_TYPE_MEMBER_INFO_CHANGE时有效
    var memberChangeInfoList: [[String: Any]]?;

    /// 当前群成员数，仅当tipsType值为V2TIMGroupTipsElem#V2TIM_GROUP_TIPS_TYPE_JOIN, V2TIMGroupTipsElem#V2TIM_GROUP_TIPS_TYPE_QUIT, V2TIMGroupTipsElem#V2TIM_GROUP_TIPS_TYPE_KICKED的时候有效
    var memberCount : UInt32?;

    override init() {
        super.init(MessageNodeType.GroupTips);
    }

    init(elem: V2TIMGroupTipsElem) {
        super.init(MessageNodeType.GroupTips);
        self.groupID = elem.groupID;
        self.type = elem.type.rawValue;
        self.opMember = CustomGroupMemberFullInfoEntity.getDict(simpleInfo: elem.opMember);
        var memberList : [[String: Any]] = [];
        for var item in elem.memberList{
            memberList.append(CustomGroupMemberFullInfoEntity.getDict(simpleInfo: item));
        }
        self.memberList = memberList;

        var groupChangeInfoList : [[String: Any]] = [];
        for var item in elem.groupChangeInfoList{
            groupChangeInfoList.append(CustomGroupChangeInfoEntity.getDict(info: item));
        }
        self.groupChangeInfoList = groupChangeInfoList;

        var memberChangeInfoList : [[String: Any]] = [];
        for var item in elem.memberChangeInfoList{
            memberChangeInfoList.append(CustomGroupMemberChangeInfoEntity.getDict(info: item));
        }
        self.memberChangeInfoList = groupChangeInfoList;

        self.memberCount = elem.memberCount;
    }
}
