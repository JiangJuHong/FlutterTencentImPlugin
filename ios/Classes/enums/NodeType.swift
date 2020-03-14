import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  节点类型
public enum NodeType : String{
    // 自定义
    case Custom = "TIMCustomElem"
    // 表情
    case Face = "TIMFaceElem"
    // 文件
    case File = "TIMFileElem"
    // 群系统消息
    case GroupSystem = "TIMGroupSystemElem"
    // 群组事件通知
    case GroupTips = "TIMGroupTipsElem"
    // 图片
    case Image = "TIMImageElem"
    // 地理位置信息
    case Location = "TIMLocationElem"
    // 用户资料变更系统通知
    case ProfileTips = "TIMProfileSystemElem"
    // 关键链变更系统通知
    case SNSTips = "TIMSNSSystemElem"
    // 语音
    case Sound = "TIMSoundElem"
    // 文本
    case Text = "TIMTextElem"
    // 微视频
    case Video = "TIMVideoElem"
    
    /**
     * 根据腾讯云获得枚举
     */
    static func getByTIMElem(elem : TIMElem)->NodeType{
        return (NodeType(rawValue: "\(type(of:elem))") ?? nil)!;
    }
}
