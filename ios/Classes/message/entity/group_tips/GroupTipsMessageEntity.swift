import ImSDK

//
//  GroupTipsMessageself.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/21.
//  群体是消息实体
public class GroupTipsMessageEntity: AbstractMessageEntity {
    override init() {
        super.init(MessageNodeType.GroupTips);
    }

    init(elem: V2TIMGroupTipsElem) {
        super.init(MessageNodeType.GroupTips);
    }
}
