import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  图片消息节点
public class ImageMessageNode: AbstractMessageNode {

    override func getV2TIMMessage(params: [String: Any]) -> V2TIMMessage {
        let path: String = getParam(params: params, paramKey: "path")!;
        return V2TIMManager.sharedInstance().createImageMessage(path)
    }

    override func getNote(elem: V2TIMElem) -> String {
        "[图片]";
    }

    override func analysis(elem: V2TIMElem) -> AbstractMessageEntity {
        let imageElem = elem as! V2TIMImageElem;
        let entity = ImageMessageEntity();
        entity.path = imageElem.path;
        entity.imageData = [];
        for item in imageElem.imageList {
            entity.imageData!.append(ImageEntity(image: item));
        }
        return entity;
    }
}
