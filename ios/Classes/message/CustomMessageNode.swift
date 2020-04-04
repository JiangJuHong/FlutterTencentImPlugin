import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  自定义消息节点
public class CustomMessageNode : AbstractMessageNode{
    
    override func getSendMessage(params: [String : Any]) -> TIMMessage? {
        let message = TIMMessage();
        let customMessage = TIMCustomElem();
        let data : String = getParam(params: params, paramKey: "data")!;
        customMessage.data = data.data(using: String.Encoding.utf8);
        message.add(customMessage);
        return message;
    }
    
    override func getNote(elem: TIMElem) -> String {
        return "[其它消息]";
    }
    
    override func analysis(elem: TIMElem) -> AbstractMessageEntity {
        let entity = CustomMessageEntity();
        entity.data = String(data: (elem as! TIMCustomElem).data, encoding: String.Encoding.utf8)!;
        return entity;
    }
}
