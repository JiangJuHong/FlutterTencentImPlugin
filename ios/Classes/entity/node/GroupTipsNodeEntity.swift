import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  群组事件通知节点
public class GroupTipsNodeEntity : NodeEntity{
    
    override init() {
    }
    
    init(elem : TIMElem) {
        super.init();
        let groupTipsElem = elem as! TIMGroupTipsElem;
        
    }
}
