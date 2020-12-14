import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  语音消息节点
public class SoundMessageNode: AbstractMessageNode {

    override func getV2TIMMessage(params: [String: Any]) -> V2TIMMessage {
        let path: String = getParam(params: params, paramKey: "path")!;
        let duration: Int32 = getParam(params: params, paramKey: "duration")!;
        return V2TIMManager.sharedInstance().createSoundMessage(path, duration: duration)
    }

    override func getNote(elem: V2TIMElem) -> String {
        "[语音]";
    }

    override func analysis(elem: V2TIMElem) -> AbstractMessageEntity {
        SoundMessageEntity(elem: elem as! V2TIMSoundElem);
    }
}
