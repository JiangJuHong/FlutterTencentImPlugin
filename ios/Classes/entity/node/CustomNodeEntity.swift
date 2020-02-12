import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  自定义节点
public class CustomNodeEntity : NodeEntity{
    
    /**
     * 离线Push时扩展字段信息（已废弃，请使用 TIMMessage 中 offlinePushInfo 进行配置）
     */
    var ext : String?;
    
    /**
     *  数据内容
     */
    var data : Data?;
    
    /**
     * 离线Push时声音字段信息（已废弃，请使用 TIMMessage 中 offlinePushInfo 进行配置）
     */
    var sound : String?;
    
    /**
     * 自定义消息描述信息，做离线Push时文本展示（已废弃，请使用 TIMMessage 中 offlinePushInfo 进行配置）
     */
    var desc : String?;
    
    override init() {
    }
    
    init(elem : TIMElem) {
        super.init();
        let customElem = elem as! TIMCustomElem;
        self.ext = customElem.ext;
        self.data = customElem.data;
        self.sound = customElem.sound;
        self.desc = customElem.desc;
    }
}
