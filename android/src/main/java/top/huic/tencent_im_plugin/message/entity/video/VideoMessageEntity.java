package top.huic.tencent_im_plugin.message.entity.video;

import top.huic.tencent_im_plugin.enums.MessageNodeType;
import top.huic.tencent_im_plugin.message.entity.AbstractMessageEntity;

/**
 * 视频消息实体
 *
 * @author 蒋具宏
 */
public class VideoMessageEntity extends AbstractMessageEntity {

    /**
     * 视频信息
     */
    private VideoInfo videoInfo;

    /**
     * 缩略图信息
     */
    private VideoSnapshotInfo videoSnapshotInfo;

    public VideoMessageEntity() {
        super(MessageNodeType.Video);
    }

    public VideoInfo getVideoInfo() {
        return videoInfo;
    }

    public void setVideoInfo(VideoInfo videoInfo) {
        this.videoInfo = videoInfo;
    }

    public VideoSnapshotInfo getVideoSnapshotInfo() {
        return videoSnapshotInfo;
    }

    public void setVideoSnapshotInfo(VideoSnapshotInfo videoSnapshotInfo) {
        this.videoSnapshotInfo = videoSnapshotInfo;
    }
}