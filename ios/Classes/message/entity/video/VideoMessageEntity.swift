//  Created by 蒋具宏 on 2020/3/15.
//  视频消息实体
public class VideoMessageEntity : AbstractMessageEntity{
   
    /// 视频信息
    var videoInfo : VideoInfo?;
    
    /// 缩略图信息
    var videoSnapshotInfo : VideoSnapshotInfo?;
    
    override init() {
        super.init(MessageNodeType.Video);
    }
}
