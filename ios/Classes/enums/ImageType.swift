import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  图片类型
public enum ImageType : Int{
    /**
     * 大图
     */
    case Large = 0x04
    /**
     * 原图
     */
    case Original = 0x01
    /**
     * 缩略图
     */
    case Thumb = 0x02
    
    /**
     * 根据腾讯云获得枚举
     */
    static func getByTIMImage(image : TIMImage)->ImageType{
        return (ImageType(rawValue: image.type.rawValue) ?? nil)!;
    }
}
