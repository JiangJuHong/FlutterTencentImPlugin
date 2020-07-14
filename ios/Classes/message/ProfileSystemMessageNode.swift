import ImSDK;

//
// Created by 蒋具宏 on 2020/7/11.
// 资料变更消息节点
class ProfileSystemMessageNode: AbstractMessageNode {
    override func getNote(elem: TIMElem) -> String {
        return "[用户资料变更]";
    }

    override func analysis(elem: TIMElem) -> AbstractMessageEntity {
        let profileSystemElem = elem as! TIMProfileSystemElem;
        return ProfileSystemMessageEntity(elem: profileSystemElem);
    }
}