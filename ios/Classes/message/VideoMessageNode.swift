import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  视频消息节点
public class VideoMessageNode: AbstractMessageNode {

    override func getV2TIMMessage(params: [String: Any]) -> V2TIMMessage {
        let path: String = getParam(params: params, paramKey: "path")!;
        let duration: Int32 = getParam(params: params, paramKey: "duration")!;
        let snapshotPath: String = getParam(params: params, paramKey: "snapshotPath")!;

        var suffix: String = "";
        if path.contains(".") {
            let ss = path.split(separator: ".");
            suffix = String(ss[ss.count - 1]);
        }
        return V2TIMManager.sharedInstance().createVideoMessage(path, type: suffix, duration: duration, snapshotPath: snapshotPath)
    }

    override func getNote(elem: V2TIMElem) -> String {
        "[视频]";
    }

    override func analysis(elem: V2TIMElem) -> AbstractMessageEntity {
        VideoMessageEntity(elem: elem as! V2TIMVideoElem);
    }
}
