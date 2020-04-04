import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  其它消息节点
public class OtherMessageNode : AbstractMessageNode{

    override func getNote(elem: TIMElem) -> String {
        return "[其它消息]";
    }
    
    override func analysis(elem: TIMElem) -> AbstractMessageEntity {
        let entity = OtherMessageEntity();
        entity.params = "{\"note\":\"IOS暂不支持该节点!\"}";
        entity.type = "\(type(of:elem))";
        return entity;
    }
}
