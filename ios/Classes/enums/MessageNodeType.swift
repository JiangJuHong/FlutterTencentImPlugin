import ImSDK

//  Created by 蒋具宏 on 2020/3/13.
//  消息节点类型
enum MessageNodeType {

    /// 文本消息
    case Text

    /// 图片
    case Image

    /// 语音
    case Sound

    /// 视频
    case Video

    /// 自定义
    case Custom

    /// 位置节点
    case Location

    /// 群提示节点
    case GroupTips

    /// 群系统消息节点
    case GroupSystem

    /// 关系链变更
    case SnsTips

    /// 资料变更
    case ProfileSystem

    /// 其它节点
    case Other


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
        case .Location:
            return LocationMessageNode();
        case .GroupTips:
            return GroupTipsMessageNode();
        case .GroupSystem:
            return GroupSystemMessageNode();
        case .SnsTips:
            return SnsTipsMessageNode();
        case .ProfileSystem:
            return ProfileSystemMessageNode();
        default:
            return OtherMessageNode();
        }
    }

    /// 根据枚举名称获得枚举
    public static func valueOf(name: String) -> MessageNodeType? {
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
        case "Location":
            return MessageNodeType.Location;
        case "GroupTips":
            return MessageNodeType.GroupTips;
        case "GroupSystem":
            return MessageNodeType.GroupSystem;
        case "SnsTips":
            return MessageNodeType.SnsTips;
        case "ProfileSystem":
            return MessageNodeType.ProfileSystem;
        default:
            return MessageNodeType.Other;
        }
    }

    /// 根据腾讯云节点获得枚举对象
    public static func getTypeByTIMElem(type: TIMElem) -> MessageNodeType? {
        if type is TIMTextElem {
            return MessageNodeType.Text;
        }

        if type is TIMImageElem {
            return MessageNodeType.Image;
        }

        if type is TIMSoundElem {
            return MessageNodeType.Sound;
        }

        if type is TIMVideoElem {
            return MessageNodeType.Video;
        }

        if type is TIMCustomElem {
            return MessageNodeType.Custom;
        }

        if type is TIMLocationElem {
            return MessageNodeType.Location;
        }

        if type is TIMGroupTipsElem {
            return MessageNodeType.GroupTips;
        }

        if type is TIMGroupSystemElem {
            return MessageNodeType.GroupSystem;
        }

        if type is TIMSNSSystemElem {
            return MessageNodeType.SnsTips;
        }

        if type is TIMProfileSystemElem {
            return MessageNodeType.ProfileSystem;
        }

        return MessageNodeType.Other;
    }
}
