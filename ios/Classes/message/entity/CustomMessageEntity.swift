import ImSDK

//  Created by 蒋具宏 on 2020/3/15.
//  自定义消息实体
public class CustomMessageEntity: AbstractMessageEntity {
    /// 自定义内容
    var data: String?;

    /// 描述
    var desc: String?;

    /// 扩展
    var ext: String?;

    override init() {
        super.init(MessageNodeType.Custom);
    }

    init(elem: V2TIMCustomElem) {
        super.init(MessageNodeType.Custom);
        self.data = String(data: elem.data, encoding: String.Encoding.utf8)!;
        if let v = elem.desc {
            self.desc = v;
        }
        if let v = elem.`extension` {
            self.ext = v;
        }
    }
}
