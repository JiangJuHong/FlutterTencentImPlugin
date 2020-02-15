import ImSDK

//  Created by 蒋具宏 on 2020/2/15.
//  群通知节点群信息实体
public class GroupTipsElemGroupInfoEntity : NSObject{
    
    var type : GroupTipsGroupInfoType?;
    var content : String?;
    var key : String?;
    
    required public override init() {
     }
    
    init(info : TIMGroupTipsElemGroupInfo) {
        super.init();
        self.content = info.value;
        self.key = info.key;
        self.type = GroupTipsGroupInfoType.getByTIM_GROUP_INFO_CHANGE_TYPE(type: info.type);
    }
}
