import ImSDK

//  Created by 蒋具宏 on 2020/3/15.
//  视频消息实体
public class VideoMessageEntity: AbstractMessageEntity {

    /**
    * 视频路径
    */
    var videoPath: String?;
    /**
     * 视频UUID
     */
    var videoUuid: String?;
    /**
     * 视频大小
     */
    var videoSize: Int32?;
    /**
     * 时长
     */
    var duration: Int32?;
    /**
     * 缩略图路径
     */
    var snapshotPath: String?;
    /**
     * 缩略图UUID
     */
    var snapshotUuid: String?;
    /**
     * 缩略图大小
     */
    var snapshotSize: Int32?;
    /**
     * 缩略图宽度
     */
    var snapshotWidth: Int32?;
    /**
     * 缩略图高度
     */
    var snapshotHeight: Int32?;

    override init() {
        super.init(MessageNodeType.Video);
    }

    init(elem: V2TIMVideoElem) {
        super.init(MessageNodeType.Video);
        self.videoUuid = elem.videoUUID;
        self.videoPath = elem.videoPath;
        self.videoSize = elem.videoSize;
        self.duration = elem.duration;
        self.snapshotUuid = elem.snapshotUUID;
        self.snapshotWidth = elem.snapshotWidth;
        self.snapshotHeight = elem.snapshotHeight;
        self.snapshotPath = elem.snapshotPath;
        self.snapshotSize = elem.snapshotSize;
    }
}