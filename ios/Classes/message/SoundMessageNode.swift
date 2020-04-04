import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  语音消息节点
public class SoundMessageNode : AbstractMessageNode{
    
    override func getSendMessage(params: [String : Any]) -> TIMMessage? {
        let message = TIMMessage();
        let soundElem = TIMSoundElem();
        soundElem.path = getParam(params: params, paramKey: "path")!;
        soundElem.second = getParam(params: params, paramKey: "duration")!
        message.add(soundElem);
        return message;
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
        entity.uuid = soundElem.uuid;
        return entity;
    }
}
