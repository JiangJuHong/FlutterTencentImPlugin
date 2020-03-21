//
//  TextMessageEntity.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/15.
//  其它消息实体
public class OtherMessageEntity : AbstractMessageEntity{
    /// 消息内容
    var params : String?;
    
    override init() {
        super.init(MessageNodeType.Other);
    }
}
