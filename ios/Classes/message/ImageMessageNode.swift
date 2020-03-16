import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  图片消息节点
public class ImageMessageNode : AbstractMessageNode{
    
    override func send(conversation: TIMConversation, params: [String : Any], ol: Bool, onCallback: @escaping (TIMMessage) -> Void, onFailCalback: @escaping GetInfoFail) {
        let message = TIMMessage();
        let imageElem = TIMImageElem();
        imageElem.path = getParam(params: params, paramKey: "path")!;
        message.add(imageElem);
        sendMessage(conversation: conversation, message: message, ol: ol, onCallback: onCallback, onFailCalback: onFailCalback);
    }
    
    override func getNote(elem: TIMElem) -> String {
        return "[图片]";
    }
    
    override func analysis(elem: TIMElem) -> AbstractMessageEntity {
        let imageElem = elem as! TIMImageElem;
        let entity = ImageMessageEntity();
        entity.imageFormat = imageElem.format.rawValue;
        entity.level = imageElem.level.rawValue;
        entity.path = imageElem.path;
        entity.imageData = [];
        for item in imageElem.imageList{
            let image = item as! TIMImage;
            entity.imageData!.append(ImageEntity(image: image));
        }
        return entity;
    }
}
