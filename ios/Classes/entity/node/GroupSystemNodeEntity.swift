import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  群系统消息节点
public class GroupSystemNodeEntity : NodeEntity{
    
    /**
     * 群ID
     */
    var groupId : String?;
    
    override init() {
    }
    
    init(elem : TIMElem) {
        super.init();
        let groupSystemElem = elem as! TIMGroupSystemElem;
        self.groupId = groupSystemElem.group;
    }
}
