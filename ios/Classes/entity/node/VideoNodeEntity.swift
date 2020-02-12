import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  微视频节点
public class VideoNodeEntity : NodeEntity{
    /**
     * 缩略图信息
     */
    var snapshotInfo : SnapshotInfoEntity?;
    
    /**
     * 获取微视频截图文件路径
     */
    var snapshotPath : String?;
    
    /**
     * 获取微视频截图文件路径
     */
    var taskId : UInt32?;
    
    /**
     * 获取视频文件路径
     */
    var videoPath : String?;
    
    /**
     * 视频信息
     */
    var videoInfo : VideoInfoEntity?;
    
    override init() {
    }
    
    init(elem : TIMElem) {
        super.init();
        let videoElem = elem as! TIMVideoElem;
        self.snapshotPath = videoElem.snapshotPath;
        self.taskId = videoElem.taskId;
        self.videoPath = videoElem.videoPath;
        self.snapshotInfo = SnapshotInfoEntity(snapshot: videoElem.snapshot);
        self.videoInfo = VideoInfoEntity(video: videoElem.video);
    }
}
