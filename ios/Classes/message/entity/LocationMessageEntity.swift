import ImSDK

//  Created by 蒋具宏 on 2020/3/15.
//  位置消息实体
public class LocationMessageEntity: AbstractMessageEntity {

    /// 描述
    var desc: String?;

    /// 经度
    var latitude: Double?;

    /// 纬度
    var longitude: Double?;

    override init() {
        super.init(MessageNodeType.Location)
    }

    init(elem: V2TIMLocationElem) {
        super.init(MessageNodeType.Location)
        self.desc = elem.desc;
        self.longitude = elem.longitude;
        self.latitude = elem.latitude;
    }
}
