import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  图片消息节点
public class ImageMessageNode : AbstractMessageNode{
    
    override func getSendMessage(params: [String : Any]) -> TIMMessage? {
        let message = TIMMessage();
        let imageElem = TIMImageElem();
        imageElem.path = getParam(params: params, paramKey: "path")!;
        imageElem.level = TIM_IMAGE_COMPRESS_TYPE.init(rawValue: getParam(params: params, paramKey: "level")!)!;
        message.add(imageElem);
        return message;
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
