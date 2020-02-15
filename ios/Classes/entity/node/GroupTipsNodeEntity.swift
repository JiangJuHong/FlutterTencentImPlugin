import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  群组事件通知节点
public class GroupTipsNodeEntity : NodeEntity{
    var intType : Int?;
    var tipsType : GroupTipsType?;
    var opUser : String?;
    var userList : [Any]?;
    var groupName : String?;
    var groupId : String?;
    var memberNum : UInt32?;
    var groupInfoList : [GroupTipsElemGroupInfoEntity]?;
    var memberInfoList : [GroupTipsElemMemberInfoEntity]?;
    var opUserInfo : UserInfoEntity?;
    var opGroupMemberInfo : GroupMemberEntity?;
    var changedUserInfo : [String:UserInfoEntity]?;
    var changedGroupMemberInfo : [String:GroupMemberEntity]?;
    var platform : String?;
    
    
    override init() {
    }
    
    init(elem : TIMElem) {
        super.init();
        let groupTipsElem = elem as! TIMGroupTipsElem;
        self.intType = groupTipsElem.type.rawValue;
        self.tipsType = GroupTipsType.getByTIM_GROUP_TIPS_TYPE(type: groupTipsElem.type);
        self.opUser = groupTipsElem.opUser;
        self.userList = groupTipsElem.userList;
        self.groupName = groupTipsElem.groupName;
        self.groupId = groupTipsElem.group;
        self.memberNum = groupTipsElem.memberNum;
        
        var groupInfoListData : [GroupTipsElemGroupInfoEntity] = [];
        for item in groupTipsElem.groupChangeList{
            groupInfoListData.append(GroupTipsElemGroupInfoEntity(info: item));
        }
        self.groupInfoList = groupInfoListData;
        
        var memberInfoListData : [GroupTipsElemMemberInfoEntity] = [];
        for item in groupTipsElem.memberChangeList{
            memberInfoListData.append(GroupTipsElemMemberInfoEntity(info: item))
        }
        self.memberInfoList = memberInfoListData;

        self.opUserInfo = UserInfoEntity(userProfile: groupTipsElem.opUserInfo);
        self.opGroupMemberInfo = GroupMemberEntity(info: groupTipsElem.opGroupMemberInfo);
        
        var changedUserInfoData : [String:UserInfoEntity] = [:];
        for(key,value) in groupTipsElem.changedUserInfo{
            changedUserInfoData[key] = UserInfoEntity(userProfile: value);
        }
        self.changedUserInfo = changedUserInfoData;
        
        var changedGroupMemberInfoData : [String:GroupMemberEntity] = [:];
        for(key,value) in groupTipsElem.changedGroupMemberInfo{
            changedGroupMemberInfoData[key] = GroupMemberEntity(info: value);
        }
        self.changedGroupMemberInfo = changedGroupMemberInfoData;
    }
}
