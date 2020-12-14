import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  位置消息节点
public class LocationMessageNode: AbstractMessageNode {

    override func getV2TIMMessage(params: [String: Any]) -> V2TIMMessage {
        let desc: String = getParam(params: params, paramKey: "desc")!;
        let longitude: Double = getParam(params: params, paramKey: "longitude")!;
        let latitude: Double = getParam(params: params, paramKey: "latitude")!;
        return V2TIMManager.sharedInstance().createLocationMessage(desc, longitude: longitude, latitude: latitude)
    }

    override func getNote(elem: V2TIMElem) -> String {
        "[位置消息]";
    }

    override func analysis(elem: V2TIMElem) -> AbstractMessageEntity {
        LocationMessageEntity(elem: elem as! V2TIMLocationElem);
    }
}
