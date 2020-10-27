package top.huic.tencent_im_plugin.message.entity;

import com.tencent.imsdk.v2.V2TIMVideoElem;

import java.io.Serializable;

import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 视频消息实体
 *
 * @author 蒋具宏
 */
public class VideoMessageEntity extends AbstractMessageEntity implements Serializable {
    /**
     * 视频路径
     */
    private String videoPath;
    /**
     * 视频UUID
     */
    private String videoUuid;
    /**
     * 视频大小
     */
    private int videoSize;
    /**
     * 时长
     */
    private int duration;
    /**
     * 缩略图路径
     */
    private String snapshotPath;
    /**
     * 缩略图UUID
     */
    private String snapshotUuid;
    /**
     * 缩略图大小
     */
    private int snapshotSize;
    /**
     * 缩略图宽度
     */
    private int snapshotWidth;
    /**
     * 缩略图高度
     */
    private int snapshotHeight;

    public VideoMessageEntity() {
        super(MessageNodeType.Video);
    }

    public VideoMessageEntity(V2TIMVideoElem elem) {
        super(MessageNodeType.Video);
        this.setVideoUuid(elem.getVideoUUID());
        this.setVideoPath(elem.getVideoPath());
        this.setVideoSize(elem.getVideoSize());
        this.setDuration(elem.getDuration());
        this.setSnapshotUuid(elem.getSnapshotUUID());
        this.setSnapshotWidth(elem.getSnapshotWidth());
        this.setSnapshotHeight(elem.getSnapshotHeight());
        this.setSnapshotPath(elem.getSnapshotPath());
        this.setSnapshotSize(elem.getSnapshotSize());
    }

    public String getVideoPath() {
        return videoPath;
    }

    public void setVideoPath(String videoPath) {
        this.videoPath = videoPath;
    }

    public String getVideoUuid() {
        return videoUuid;
    }

    public void setVideoUuid(String videoUuid) {
        this.videoUuid = videoUuid;
    }

    public int getVideoSize() {
        return videoSize;
    }

    public void setVideoSize(int videoSize) {
        this.videoSize = videoSize;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getSnapshotPath() {
        return snapshotPath;
    }

    public void setSnapshotPath(String snapshotPath) {
        this.snapshotPath = snapshotPath;
    }

    public String getSnapshotUuid() {
        return snapshotUuid;
    }

    public void setSnapshotUuid(String snapshotUuid) {
        this.snapshotUuid = snapshotUuid;
    }

    public int getSnapshotSize() {
        return snapshotSize;
    }

    public void setSnapshotSize(int snapshotSize) {
        this.snapshotSize = snapshotSize;
    }

    public int getSnapshotWidth() {
        return snapshotWidth;
    }

    public void setSnapshotWidth(int snapshotWidth) {
        this.snapshotWidth = snapshotWidth;
    }

    public int getSnapshotHeight() {
        return snapshotHeight;
    }

    public void setSnapshotHeight(int snapshotHeight) {
        this.snapshotHeight = snapshotHeight;
    }
}