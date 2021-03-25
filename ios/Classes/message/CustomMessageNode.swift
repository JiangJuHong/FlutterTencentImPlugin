import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  自定义消息节点
public class CustomMessageNode: AbstractMessageNode {

    override func getV2TIMMessage(params: [String: Any]) -> V2TIMMessage {
        let data: String = getParam(params: params, paramKey: "data")!;
        let desc: String? = getParam(params: params, paramKey: "desc");
        let ext: String? = getParam(params: params, paramKey: "ext");
        return V2TIMManager.sharedInstance().createCustomMessage(data.data(using: String.Encoding.utf8), desc: desc, extension: ext)
    }

    override func getNote(elem: V2TIMElem) -> String {
        "[其它消息]"
    }

    override func analysis(elem: V2TIMElem) -> AbstractMessageEntity {
        CustomMessageEntity(elem: elem as! V2TIMCustomElem)
    }
}
