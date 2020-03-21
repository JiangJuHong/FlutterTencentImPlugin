import ImSDK;

//
//  GroupTipsElemGroupInfoEntity.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/21.
//  群 tips，群变更信息
class GroupTipsElemGroupInfoEntity : NSObject{
    /// 消息内容
    var content : String?;
    
    /// 如果变更类型是群自定义字段，key 对应的是具体变更的字段，群自定义字段的变更只会通过 TIMUserConfig -> TIMGroupEventListener 回调给客户
    var key : String?;
    
    /// 群资料变更消息类型
    var type : GroupTipsGroupInfoType?;
    
    init(info : TIMGroupTipsElemGroupInfo) {
        super.init();
        self.content = info.value;
        self.key = info.key;
        self.type = GroupTipsGroupInfoType.getByTIM_GROUP_INFO_CHANGE_TYPE(type: info.type);
    }
}
