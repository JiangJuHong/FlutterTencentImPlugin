import ImSDK

//
// Created by 蒋具宏 on 2020/7/11.
// 资料变更消息实体
class ProfileSystemMessageEntity: AbstractMessageEntity {

    /// 子类型
    var subType: Int?;

    /// 资料变更的用户名
    var fromUser: String?;

    /// 资料变更的昵称
    var nickName: String?;

    override init() {
        super.init(MessageNodeType.ProfileSystem);
    }

    init(elem: TIMProfileSystemElem) {
        super.init(MessageNodeType.ProfileSystem);
        self.subType = elem.type.rawValue;
        self.fromUser = elem.fromUser;
        self.nickName = elem.nickName;
    }
}