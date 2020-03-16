import ImSDK

//  Created by 蒋具宏 on 2020/2/10.
//  图片实体
public class ImageEntity : NSObject{
    
    /**
     * 大小
     */
    var size : Int32?;

    /**
     * 宽度
     */
    var width : Int32?;

    /**
     * 类型
     */
    var type : ImageType?;

    /**
     * url
     */
    var url : String?;

    /**
     * 高度
     */
    var height : Int32?;
    
    override init() {
    }
    
    init(image : TIMImage) {
        super.init();
        self.size = image.size;
        self.width = image.width;
        self.type = ImageType.getByTIMImage(image: image);
        self.url = image.url;
        self.height = image.height;
    }
}
