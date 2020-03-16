//  Created by 蒋具宏 on 2020/3/15.
//  图片消息实体
public class ImageMessageEntity : AbstractMessageEntity{
   
    /// 路径
    var path : String?;
    
    /// 类型
    var imageFormat : Int?;
    
    /// 质量
    var level : Int?;
    
    /// 图片数据
    var imageData : [ImageEntity]?;
    
    override init() {
        super.init(MessageNodeType.Image);
    }
}
