import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  自定义节点
public class CustomNodeEntity : NodeEntity{
    /**
     *  数据内容
     */
    var data : Data?;
    
    override init() {
    }
    
    init(elem : TIMElem) {
        super.init();
        let customElem = elem as! TIMCustomElem;
        self.data = customElem.data;
    }
}
