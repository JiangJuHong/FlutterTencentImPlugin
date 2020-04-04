import ImSDK

//
//  GroupTipsMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/21.
//  群提示消息节点
public class GroupTipsMessageNode : AbstractMessageNode{
    override func getNote(elem: TIMElem) -> String {
        return "[群提示消息]";
    }
    
    override func analysis(elem: TIMElem) -> AbstractMessageEntity {
        let groupTipsElem = elem as! TIMGroupTipsElem;
        return GroupTipsMessageEntity(elem: groupTipsElem);
    }
}
