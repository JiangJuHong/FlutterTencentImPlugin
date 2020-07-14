import ImSDK


//
// Created by 蒋具宏 on 2020/7/11.
// 群系统提示节点
public class GroupSystemMessageNode: AbstractMessageNode {
    override func getNote(elem: TIMElem) -> String {
        return "[群系统消息]";
    }

    override func analysis(elem: TIMElem) -> AbstractMessageEntity {
        let groupSystemElem = elem as! TIMGroupSystemElem;
        return GroupSystemMessageEntity(elem: groupSystemElem);
    }
}
