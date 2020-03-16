import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  视频消息节点
public class VideoMessageNode : AbstractMessageNode{
    
    override func send(conversation: TIMConversation, params: [String : Any], ol: Bool, onCallback: @escaping (TIMMessage) -> Void, onFailCalback: @escaping GetInfoFail) {
        
        // 视频数据
        let video = TIMVideo();
        video.duration = getParam(params: params, paramKey: "duration")!;
        video.type = getParam(params: params, paramKey: "type")!;

        // 缩略图数据
        let snapshot = TIMSnapshot();
        snapshot.width = getParam(params: params, paramKey: "snapshotWidth")!;
        snapshot.height = getParam(params: params, paramKey: "snapshotHeight")!;

        // 消息数据
        let message = TIMMessage();
        let videoElem = TIMVideoElem();
        videoElem.videoPath = getParam(params: params, paramKey: "path")!;
        videoElem.video = video;
        videoElem.snapshotPath = getParam(params: params, paramKey: "snapshotPath")!;
        videoElem.snapshot = snapshot;
        message.add(videoElem);
        sendMessage(conversation: conversation, message: message, ol: ol, onCallback: onCallback, onFailCalback: onFailCalback);
    }
    
    override func getNote(elem: TIMElem) -> String {
        return "[视频]";
    }
    
    override func analysis(elem: TIMElem) -> AbstractMessageEntity {
        let videoElem = elem as! TIMVideoElem;
        let entity = VideoMessageEntity();
        let videoInfo = VideoInfo();
        let videoSnapshotInfo = VideoSnapshotInfo();
        
        videoInfo.duration = videoElem.video.duration;
        videoInfo.path = videoElem.videoPath;
        videoInfo.size = videoElem.video.size;
        videoInfo.type = videoElem.video.type;
        
        videoSnapshotInfo.height = videoElem.snapshot.height;
        videoSnapshotInfo.width = videoElem.snapshot.width;
        videoSnapshotInfo.path = videoElem.snapshotPath;
        videoSnapshotInfo.type = videoElem.snapshot.type;
        videoSnapshotInfo.size = videoElem.snapshot.size;
    
        entity.videoInfo = videoInfo;
        entity.videoSnapshotInfo = videoSnapshotInfo;
        return entity;
    }
}
