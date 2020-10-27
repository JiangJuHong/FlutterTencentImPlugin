import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  文本消息节点
public class TextMessageNode: AbstractMessageNode {
    override func getV2TIMMessage(params: [String: Any]) -> V2TIMMessage {
        let text: String = getParam(params: params, paramKey: "content")!;
        let atUserList: Any? = getParam(params: params, paramKey: "atUserList");

        if atUserList == nil || atUserList is NSNull {
            return V2TIMManager.sharedInstance().createTextMessage(text);
        }
        return V2TIMManager.sharedInstance().createText(atMessage: text, atUserList: (atUserList as! NSMutableArray))
    }

    override func getNote(elem: V2TIMElem) -> String {
        (elem as! V2TIMTextElem).text ?? "";
    }

    override func analysis(elem: V2TIMElem) -> AbstractMessageEntity {
        TextMessageEntity(elem: elem as! V2TIMTextElem)
    }
}
