//
//  AbstractMessageEntity.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/15.
//  抽象消息实体
public class AbstractMessageEntity : NSObject{
    var nodeType : MessageNodeType?;
    
    override init() {
    }
    
    init(_ type : MessageNodeType) {
        nodeType = type;
    }
}
