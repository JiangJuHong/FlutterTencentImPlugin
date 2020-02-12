import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  文本节点
public class TextNodeEntity : NodeEntity{
    
    /**
     * 文本内容
     */
    var text : String?;
    
    override init() {
    }
    
    init(elem : TIMElem) {
        super.init();
        let textElem = elem as! TIMTextElem;
        self.text = textElem.text;
    }
}
