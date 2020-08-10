import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  文本消息节点
public class TextMessageNode: AbstractMessageNode {

    override func getSendMessage(params: [String: Any]) -> TIMMessage? {
        let message = TIMMessage();
        let textElem = TIMTextElem();
        textElem.text = getParam(params: params, paramKey: "content")!;
        message.add(textElem);
        return message;
    }

    override func getNote(elem: TIMElem) -> String {
        return (elem as! TIMTextElem).text ?? "";
    }

    override func analysis(elem: TIMElem) -> AbstractMessageEntity {
        let entity = TextMessageEntity();
        entity.content = (elem as! TIMTextElem).text;
        return entity;
    }
}
