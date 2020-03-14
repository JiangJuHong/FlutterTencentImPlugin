import ImSDK

//
//  AbstractMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  消息节点抽象
public class AbstractMessageNode {
    /**
     * 发送消息
     *
     * @param conversation 会话
     * @param onCallback   结果回调
     * @param params       参数
     * @param ol           是否在线消息
     */
    func send(conversation : TIMConversation, params : [String:Any], ol : Bool, onCallback : @escaping GetInfoSuc,onFailCalback :  @escaping GetInfoFail){
        
    }
    
    /**
     * 根据消息节点获得描述
     *
     * @param elem 节点
     */
    func getNote(elem : TIMElem) -> String?{
        return nil;
    }
    
    
    /**
     * 发送消息
     *
     * @param conversation 会话
     * @param message      消息内容
     * @param ol           是否使用在线消息发送
     * @param onCallback   结果回调
     */
    func sendMessage(conversation : TIMConversation, message : TIMMessage, ol : Bool, onCallback :  @escaping GetInfoSuc, onFailCalback : @escaping GetInfoFail) {
        
        /// 成功回调
        let successCallback = {
            () -> Void in
            onCallback(message);
        };
        
        if ol {
            conversation.sendOnlineMessage(message, succ: successCallback, fail:onFailCalback);
        } else {
            conversation.send(message, succ: successCallback, fail:onFailCalback);
        }
    }
    
    /// 获得参数
    func getParam<T>(params : [AnyHashable:Any], paramKey : AnyHashable) -> T! {
        if let value = params[paramKey]{
            return (value as! T);
        }
        return nil;
    }
    
    /// 发送消息回调
    typealias GetInfoSuc = (_ array : TIMMessage) -> Void;
}
