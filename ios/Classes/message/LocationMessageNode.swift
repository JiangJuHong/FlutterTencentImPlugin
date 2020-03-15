import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  位置消息节点
public class LocationMessageNode : AbstractMessageNode{
    
    override func send(conversation: TIMConversation, params: [String : Any], ol: Bool, onCallback: @escaping (TIMMessage) -> Void, onFailCalback: @escaping GetInfoFail) {
        let message = TIMMessage();
        let locationElem = TIMLocationElem();
        locationElem.desc = getParam(params: params, paramKey: "desc")!
        locationElem.longitude = getParam(params: params, paramKey: "longitude")!;
        locationElem.latitude = getParam(params: params, paramKey: "latitude")!;
        message.add(locationElem);
        sendMessage(conversation: conversation, message: message, ol: ol, onCallback: onCallback, onFailCalback: onFailCalback);
    }
    
    override func getNote(elem: TIMElem) -> String {
        return "[位置消息]";
    }
}