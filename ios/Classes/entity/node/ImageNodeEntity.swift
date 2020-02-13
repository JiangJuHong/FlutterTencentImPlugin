import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  图片节点
public class ImageNodeEntity : NodeEntity{
    
    /**
     * 图片类型
     */
    var imageFormat : Int?;
    
    /**
     * 原图本地路径
     */
    var path : String?;
    
    /**
     * 图片质量级别，0: 原图发送 1: 高压缩率图发送(图片较小) 2:高清图发送(图片较大)
     */
    var level : Int?;
    
    /**
     * 图片上传任务id, 调用sendMessage后此接口的返回值有效
     */
    var taskId : UInt32?;
    
    /**
     * 图片列表
     */
    var imageList : [ImageEntity] = [];
    
    override init() {
    }
    
    init(elem : TIMElem) {
        super.init();
        let imageElem = elem as! TIMImageElem;
        self.imageFormat = imageElem.format.rawValue;
        self.path = imageElem.path;
        self.level = imageElem.level.rawValue;
        self.taskId = imageElem.taskId;
        for item in imageElem.imageList{
            let image = item as! TIMImage;
            self.imageList.append(ImageEntity(image: image));
        }
    }
}
