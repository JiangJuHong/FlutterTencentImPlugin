import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  位置消息节点
public class LocationMessageNode : AbstractMessageNode{
    
    override func getSendMessage(params: [String : Any]) -> TIMMessage? {
        let message = TIMMessage();
        let locationElem = TIMLocationElem();
        locationElem.desc = getParam(params: params, paramKey: "desc")!
        locationElem.longitude = getParam(params: params, paramKey: "longitude")!;
        locationElem.latitude = getParam(params: params, paramKey: "latitude")!;
        message.add(locationElem);
        return message;
    }
    
    override func getNote(elem: TIMElem) -> String {
        return "[位置消息]";
    }
    
    override func analysis(elem: TIMElem) -> AbstractMessageEntity {
        let locationElem = elem as! TIMLocationElem;
        let entity = LocationMessageEntity();
        entity.desc = locationElem.desc;
        entity.longitude = locationElem.longitude;
        entity.latitude = locationElem.latitude;
        return entity;
    }
}
