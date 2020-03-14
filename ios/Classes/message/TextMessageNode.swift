import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  文本消息节点
public class TextMessageNode : AbstractMessageNode{
    
    override func send(conversation: TIMConversation, params: [String : Any], ol: Bool, onCallback: @escaping (TIMMessage) -> Void, onFailCalback: @escaping GetInfoFail) {
        let message = TIMMessage();
        let textElem = TIMTextElem();
        textElem.text = getParam(params: params, paramKey: "content")!;
        message.add(textElem);
        sendMessage(conversation: conversation, message: message, ol: ol, onCallback: onCallback, onFailCalback: onFailCalback);
    }
    
    override func getNote(elem: TIMElem) -> String {
        return (elem as! TIMTextElem).text!;
    }
}
