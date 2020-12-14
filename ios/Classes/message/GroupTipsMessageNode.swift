import ImSDK

//
//  GroupTipsMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/21.
//  群提示消息节点
public class GroupTipsMessageNode: AbstractMessageNode {
    override func getNote(elem: V2TIMElem) -> String {
        "[群提示]";
    }

    override func analysis(elem: V2TIMElem) -> AbstractMessageEntity {
        GroupTipsMessageEntity(elem: elem as! V2TIMGroupTipsElem);
    }
}
