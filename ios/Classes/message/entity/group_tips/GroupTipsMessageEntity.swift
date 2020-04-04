import ImSDK

//
//  GroupTipsMessageself.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/21.
//  群体是消息实体
public class GroupTipsMessageEntity : AbstractMessageEntity{
    
    /// 被操作者群内资料
    var changedGroupMemberInfo : [String:GroupMemberEntity]?;
    
    /// 被操作者个人资料
    var changedUserInfo : [String:UserInfoEntity]?;
    
    /// 群ID
    var groupId : String?;
    
    /// 群名称
    var groupName : String?;
    
    /// 群资料变更列表信息 仅当tipsType值为TIMGroupTipsType.ModifyGroupInfo时有效
    var groupInfoList : [GroupTipsElemGroupInfoEntity]?;
    
    /// 群成员变更信息列表，仅当tipsType值为TIMGroupTipsType.ModifyMemberInfo时有效
    var memberInfoList : [GroupTipsElemMemberInfoEntity]?;
    
    /// 群成员数量
    var memberNum : UInt32?;
    
    /// 操作者群内信息
    var opGroupMemberInfo : GroupMemberEntity?;
    
    /// 操作者ID
    var opUser : String?;
    
    /// 操作者群内资料
    var opUserInfo : UserInfoEntity?;
    
    /// 操作方平台资料
    var platform : String?;
    
    /// 群组事件通知类型
    var tipsType : GroupTipsType?;
    
    /// 被操作的帐号列表
    var userList : [String]?;
    
    override init() {
        super.init(MessageNodeType.GroupTips);
    }
    
    init(elem : TIMGroupTipsElem){
        super.init(MessageNodeType.GroupTips);
        if elem.changedGroupMemberInfo != nil{
            self.changedGroupMemberInfo = [:];
            for (key,value) in elem.changedGroupMemberInfo! {
                self.changedGroupMemberInfo![key] = GroupMemberEntity(info: value);
            }
        }
        
        if elem.changedUserInfo != nil{
            self.changedUserInfo = [:];
            for (key,value) in elem.changedUserInfo! {
                self.changedUserInfo![key] = UserInfoEntity(userProfile: value);
            }
        }
        
        self.groupId = elem.group;
        self.groupName = elem.groupName;
        
        if elem.groupChangeList != nil{
            self.groupInfoList = [];
            for item in elem.groupChangeList!{
                self.groupInfoList?.append(GroupTipsElemGroupInfoEntity(info: item));
            }
        }
        
        if elem.memberChangeList != nil{
            self.memberInfoList = [];
            for item in elem.memberChangeList!{
                self.memberInfoList?.append(GroupTipsElemMemberInfoEntity(info: item));
            }
        }
        
        self.memberNum = elem.memberNum;
        
        if elem.opGroupMemberInfo != nil{
            self.opGroupMemberInfo = GroupMemberEntity(info: elem.opGroupMemberInfo!);
        }
        self.opUser = elem.opUser;
        
        if elem.opUserInfo != nil{
            self.opUserInfo = UserInfoEntity(userProfile: elem.opUserInfo!);
        }
        self.platform = elem.platform;
        self.tipsType = GroupTipsType.getByTIM_GROUP_TIPS_TYPE(type: elem.type)
        self.userList = (elem.userList as! [String]);
    }
}
