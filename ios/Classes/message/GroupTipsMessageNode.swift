import ImSDK

//
//  GroupTipsMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/21.
//  群提示消息节点
public class GroupTipsMessageNode : AbstractMessageNode{
    
    override func send(conversation: TIMConversation, params: [String : Any], ol: Bool, onCallback: @escaping (TIMMessage) -> Void, onFailCalback: @escaping GetInfoFail) {
        
    }
    
    override func getNote(elem: TIMElem) -> String {
        return "[群提示消息]";
    }
    
    override func analysis(elem: TIMElem) -> AbstractMessageEntity {
        let groupTipsElem = elem as! TIMGroupTipsElem;
        
        let entity = GroupTipsMessageEntity();
        if groupTipsElem.changedGroupMemberInfo != nil{
            entity.changedGroupMemberInfo = [:];
            for (key,value) in groupTipsElem.changedGroupMemberInfo! {
                entity.changedGroupMemberInfo![key] = GroupMemberEntity(info: value);
            }
        }
        
        if groupTipsElem.changedUserInfo != nil{
            entity.changedUserInfo = [:];
            for (key,value) in groupTipsElem.changedUserInfo! {
                entity.changedUserInfo![key] = UserInfoEntity(userProfile: value);
            }
        }
        
        entity.groupId = groupTipsElem.group;
        entity.groupName = groupTipsElem.groupName;
        
        if groupTipsElem.groupChangeList != nil{
            entity.groupInfoList = [];
            for item in groupTipsElem.groupChangeList!{
                entity.groupInfoList?.append(GroupTipsElemGroupInfoEntity(info: item));
            }
        }
        
        if groupTipsElem.memberChangeList != nil{
            entity.memberInfoList = [];
            for item in groupTipsElem.memberChangeList!{
                entity.memberInfoList?.append(GroupTipsElemMemberInfoEntity(info: item));
            }
        }
        
        entity.memberNum = groupTipsElem.memberNum;
        
        if groupTipsElem.opGroupMemberInfo != nil{
            entity.opGroupMemberInfo = GroupMemberEntity(info: groupTipsElem.opGroupMemberInfo!);
        }
        entity.opUser = groupTipsElem.opUser;
        
        if groupTipsElem.opUserInfo != nil{
            entity.opUserInfo = UserInfoEntity(userProfile: groupTipsElem.opUserInfo!);
        }
        entity.platform = groupTipsElem.platform;
        entity.tipsType = GroupTipsType.getByTIM_GROUP_TIPS_TYPE(type: groupTipsElem.type)
        entity.userList = (groupTipsElem.userList as! [String]);
        return entity;
    }
}
