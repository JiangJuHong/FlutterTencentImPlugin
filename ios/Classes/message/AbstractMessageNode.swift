import ImSDK

//
//  AbstractMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  消息节点抽象
public class AbstractMessageNode {

    /**
     * 获得发送的消息体
     * @param params 参数
     */
    func getV2TIMMessage(params: [String: Any]) -> V2TIMMessage {
        return V2TIMMessage();
    }

    /**
     * 根据消息节点获得描述
     *
     * @param elem 节点
     */
    func getNote(elem: V2TIMElem) -> String? {
        return nil;
    }

    /// 根据节点解析为实体对象
    func analysis(elem: V2TIMElem) -> AbstractMessageEntity? {
        return nil;
    }

    /// 获得参数
    func getParam<T>(params: [AnyHashable: Any], paramKey: AnyHashable) -> T? {
        if let value = params[paramKey] {
            return (value as! T);
        }
        return nil;
    }
}
