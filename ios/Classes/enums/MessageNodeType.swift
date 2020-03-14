import ImSDK

//  Created by 蒋具宏 on 2020/3/13.
//  消息节点类型
enum MessageNodeType{
    
    /// 文本消息
    case Text
    
    /// 图片
    case Image
    
    /// 语音
    case Sound
    
    /// 视频
    case Video
    
    /// 自定义
    case Custom;
    
    func messageNodeInterface() -> AbstractMessageNode {
        switch self {
        case .Text:
            return TextMessageNode();
        case .Image:
            return ImageMessageNode()
        case .Sound:
            return SoundMessageNode()
        case .Video:
            return VideoMessageNode()
        case .Custom:
            return CustomMessageNode()
        }
    }
    
    /// 根据枚举名称获得枚举
    public static func valueOf(name : String) -> MessageNodeType?{
        switch name {
        case "Text":
            return MessageNodeType.Text;
        case "Image":
            return MessageNodeType.Image;
        case "Sound":
            return MessageNodeType.Sound;
        case "Video":
            return MessageNodeType.Video;
        case "Custom":
            return MessageNodeType.Custom;
        default:
            return nil;
        }
    }
    
    /// 根据腾讯云节点获得枚举对象
    public static func getTypeByTIMElem(type : TIMElem) -> MessageNodeType?{
        if type is TIMTextElem{
            return MessageNodeType.Text;
        }
        
        if type is TIMImageElem{
            return MessageNodeType.Image;
        }
        
        if type is TIMSoundElem{
            return MessageNodeType.Sound;
        }
        
        if type is TIMVideoElem{
            return MessageNodeType.Video;
        }
        
        if type is TIMCustomElem{
            return MessageNodeType.Custom;
        }
        
        return nil;
    }
}
