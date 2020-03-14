import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  自定义消息节点
public class CustomMessageNode : AbstractMessageNode{
    
    override func send(conversation: TIMConversation, params: [String : Any], ol: Bool, onCallback: @escaping (TIMMessage) -> Void, onFailCalback: @escaping GetInfoFail) {
        let message = TIMMessage();
        let customMessage = TIMCustomElem();
        let data : String = getParam(params: params, paramKey: "data")!;
        customMessage.data = data.data(using: String.Encoding.utf8);
        message.add(customMessage);
        sendMessage(conversation: conversation, message: message, ol: ol, onCallback: onCallback, onFailCalback: onFailCalback);
    }
    
    override func getNote(elem: TIMElem) -> String {
        return "[其它消息]";
    }
}
