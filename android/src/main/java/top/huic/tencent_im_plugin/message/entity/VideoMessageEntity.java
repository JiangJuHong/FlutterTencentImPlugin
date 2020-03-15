package top.huic.tencent_im_plugin.message.entity;

/**
 * 视频消息实体
 *
 * @author 蒋具宏
 */
public class VideoMessageEntity {
    /**
     * 视频路径
     */
    private String path;

    /**
     * 时长
     */
    private Integer duration;

    /**
     * 类型
     */
    private String type;

    /**
     * 缩略图宽度
     */
    private Integer snapshotWidth;

    /**
     * 缩略图高度
     */
    private Integer snapshotHeight;

    /**
     * 缩略图路径
     */
    private String snapshotPath;

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getSnapshotWidth() {
        return snapshotWidth;
    }

    public void setSnapshotWidth(Integer snapshotWidth) {
        this.snapshotWidth = snapshotWidth;
    }

    public Integer getSnapshotHeight() {
        return snapshotHeight;
    }

    public void setSnapshotHeight(Integer snapshotHeight) {
        this.snapshotHeight = snapshotHeight;
    }

    public String getSnapshotPath() {
        return snapshotPath;
    }

    public void setSnapshotPath(String snapshotPath) {
        this.snapshotPath = snapshotPath;
    }
}