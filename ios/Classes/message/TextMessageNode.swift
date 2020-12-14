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
        let atAll: Any? = getParam(params: params, paramKey: "atAll");

        // 有@用户或者@所有人则进入分支
        if (atUserList != nil && !(atUserList is NSNull)) || (atAll != nil && atAll is NSNull && atAll as! Bool) {
            var atList: [String] = [];

            // 追加@的目标
            if atUserList != nil && !(atUserList is NSNull) {
                for item in atUserList as! [String] {
                    atList.append(item);
                }
            }

            // @所有人
            if atAll != nil && atAll is NSNull && atAll as! Bool {
                atList.append(kImSDK_MesssageAtALL);
            }

            return V2TIMManager.sharedInstance().createText(atMessage: text, atUserList: (atList as AnyObject as! NSArray).mutableCopy() as! NSMutableArray)
        }
        return V2TIMManager.sharedInstance().createTextMessage(text);
    }

    override func getNote(elem: V2TIMElem) -> String {
        (elem as! V2TIMTextElem).text ?? "";
    }

    override func analysis(elem: V2TIMElem) -> AbstractMessageEntity {
        TextMessageEntity(elem: elem as! V2TIMTextElem)
    }
}
