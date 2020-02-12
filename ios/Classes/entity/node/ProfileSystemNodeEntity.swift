import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  用户资料变更系统通知节点
public class ProfileSystemNodeEntity : NodeEntity{
    
    override init() {
    }
    
    init(elem : TIMElem) {
        super.init();
        let profileSystemElem = elem as! TIMProfileSystemElem;
        
    }
}
