import ImSDK

//  Created by 蒋具宏 on 2020/3/13.
//  消息节点类型
enum MessageNodeType: Int {
    // 没有元素
    case None

    // 文本
    case Text

    // 自定义
    case Custom

    // 图片
    case Image

    // 语音
    case Sound

    // 视频
    case Video

    // 文件
    case File

    // 位置
    case Location

    // 表情
    case Face

    // 群提示
    case GroupTips


    /// 获得消息节点接口
    func messageNodeInterface() -> AbstractMessageNode {
        switch self {
        case .None:
            return AbstractMessageNode();
        case .Text:
            return TextMessageNode()
        case .Custom:
            return CustomMessageNode();
        case .Image:
            return ImageMessageNode();
        case .Sound:
            return SoundMessageNode();
        case .Video:
            return VideoMessageNode();
        case .File:
            return FileMessageNode();
        case .Location:
            return LocationMessageNode();
        case .Face:
            return FaceMessageNode();
        case .GroupTips:
            return GroupTipsMessageNode();
        }
    }

    /// 根据腾讯云节点获得枚举对象
    public static func getMessageNodeTypeByV2TIMConstant(constant: Int) -> MessageNodeType {
        MessageNodeType.init(rawValue: constant)!
    }

    /// 根据Message获得节点信息
    public static func getElemByMessage(message: V2TIMMessage) -> V2TIMElem? {
        let messageType = getMessageNodeTypeByV2TIMConstant(constant: message.elemType.rawValue);
        switch messageType {
        case .None:
            return nil;
        case .Text:
            return message.textElem;
        case .Custom:
            return message.customElem;
        case .Image:
            return message.imageElem;
        case .Sound:
            return message.soundElem;
        case .Video:
            return message.videoElem;
        case .File:
            return message.fileElem;
        case .Location:
            return message.locationElem;
        case .Face:
            return message.faceElem;
        case .GroupTips:
            return message.groupTipsElem;
        }
    }

}
