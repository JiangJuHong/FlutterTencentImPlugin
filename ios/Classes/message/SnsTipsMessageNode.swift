import ImSDK

//
//  GroupTipsMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/21.
//  关系链变更消息节点
public class SnsTipsMessageNode : AbstractMessageNode{
    override func getNote(elem: TIMElem) -> String {
        return "[关系链变更消息]";
    }
    
    override func analysis(elem: TIMElem) -> AbstractMessageEntity {
        let snsTipsElem = elem as! TIMSNSSystemElem;
        return SnsTipsMessageEntity(elem: snsTipsElem);
    }
}
