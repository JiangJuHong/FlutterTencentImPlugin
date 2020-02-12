import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  表情节点
public class FaceNodeEntity : NodeEntity{
    
    /**
     * 索引
     */
    var index : Int32?;
    
    /**
     * 自定义数据
     */
    var data : Data?;
    
    override init() {
    }
    
    init(elem : TIMElem) {
        super.init();
        let faceElem = elem as! TIMFaceElem;
        self.index = faceElem.index;
        self.data = faceElem.data;
    }
}
