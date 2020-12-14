import ImSDK

//
//  TextMessageEntity.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/15.
//  文本消息实体
public class TextMessageEntity: AbstractMessageEntity {
    /// 消息内容
    var content: String?;

    override init() {
        super.init(MessageNodeType.Text);
    }

    init(elem: V2TIMTextElem) {
        super.init(MessageNodeType.Text);
        self.content = elem.text;
    }
}
