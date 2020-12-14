import ImSDK

//  Created by 蒋具宏 on 2020/3/15.
//  语音消息实体
public class SoundMessageEntity: AbstractMessageEntity {

    /// 语音ID
    var uuid: String?;

    /// 路径
    var path: String?;

    /// 时长
    var duration: Int32?;

    /// 数据大小
    var dataSize: Int32?;

    override init() {
        super.init(MessageNodeType.Sound);
    }

    init(elem: V2TIMSoundElem) {
        super.init(MessageNodeType.Sound);
        self.path = elem.path;
        self.dataSize = elem.dataSize;
        self.duration = elem.duration;
        self.uuid = elem.uuid;
    }
}