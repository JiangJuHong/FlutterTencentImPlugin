import ImSDK

//
//  TextMessageNode.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/3/13.
//  视频消息节点
public class VideoMessageNode : AbstractMessageNode{
    
    override func send(conversation: TIMConversation, params: [String : Any], ol: Bool, onCallback: @escaping (TIMMessage) -> Void, onFailCalback: @escaping GetInfoFail) {
        
        let videoInfo = params["videoInfo"] as! [String : Any];
        let videoSnapshotInfo = params["videoSnapshotInfo"]  as! [String : Any];
        
        // 视频数据
        let video = TIMVideo();
        video.duration = videoInfo["duration"] as! Int32;
        video.type = (videoInfo["type"] as! String);

        // 缩略图数据
        let snapshot = TIMSnapshot();
        snapshot.width = videoSnapshotInfo["width"] as! Int32;
        snapshot.height = videoSnapshotInfo["height"] as! Int32;

        // 消息数据
        let message = TIMMessage();
        let videoElem = TIMVideoElem();
        videoElem.videoPath = (videoInfo["path"] as! String);
        videoElem.video = video;
        videoElem.snapshotPath = (videoSnapshotInfo["path"] as! String);
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
