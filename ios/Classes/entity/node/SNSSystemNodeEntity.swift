import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  关键链变更系统通知节点
public class SNSSystemNodeEntity : NodeEntity{
    
    override init() {
    }
    
    init(elem : TIMElem) {
        super.init();
        let sNSSystemElem = elem as! TIMSNSSystemElem;
        
    }
}
