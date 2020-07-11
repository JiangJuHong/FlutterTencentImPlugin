import ImSDK

//
// Created by 蒋具宏 on 2020/7/11.
// 群系统消息实体
class GroupSystemMessageEntity: AbstractMessageEntity {
    /// 操作方平台信息
    /// 取值： iOS Android Windows Mac Web RESTAPI Unknown
    var platform: String?;

    /// 消息子类型
    var subtype: Int?;

    /// 群ID
    var groupId: String?;

    /// 自定义数据
    var userData: Data?;

    /// 操作者个人资料
    var opUserInfo: UserInfoEntity?;

    /// 操作者群内资料
    var opGroupMemberInfo: GroupMemberEntity?;

    override init() {
        super.init(MessageNodeType.GroupSystem);
    }

    init(elem: TIMGroupSystemElem) {
        super.init(MessageNodeType.GroupSystem);
        self.platform = elem.platform;
        self.subtype = elem.type.rawValue;
        self.groupId = elem.group;
        self.userData = elem.userData;
        self.opUserInfo = UserInfoEntity(userProfile: elem.opUserInfo);
        self.opGroupMemberInfo = GroupMemberEntity(info: elem.opGroupMemberInfo);
    }
}