import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  语音消息节点
public class SoundMessageNode : AbstractMessageNode{
    
    override func send(conversation: TIMConversation, params: [String : Any], ol: Bool, onCallback: @escaping (TIMMessage) -> Void, onFailCalback: @escaping GetInfoFail) {
        let message = TIMMessage();
        let soundElem = TIMSoundElem();
        soundElem.path = getParam(params: params, paramKey: "path")!;
        soundElem.second = getParam(params: params, paramKey: "duration")!
        message.add(soundElem);
        sendMessage(conversation: conversation, message: message, ol: ol, onCallback: onCallback, onFailCalback: onFailCalback);
    }
    
    override func getNote(elem: TIMElem) -> String {
        return "[语音]";
    }
    
    override func analysis(elem: TIMElem) -> AbstractMessageEntity {
        let soundElem = elem as! TIMSoundElem;
        let entity = SoundMessageEntity();
        entity.path = soundElem.path;
        entity.dataSize = soundElem.dataSize;
        entity.duration = soundElem.second;
        return entity;
    }
}
