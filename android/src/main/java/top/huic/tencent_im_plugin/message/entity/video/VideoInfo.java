package top.huic.tencent_im_plugin.message.entity.video;

import java.io.Serializable;

/**
 * 视频信息实体
 *
 * @author 蒋具宏
 */
public class VideoInfo implements Serializable {
    /**
     * 视频ID
     */
    private String uuid;

    /**
     * 时长
     */
    private Long duration;

    /**
     * 大小
     */
    private Long size;

    /**
     * 类型
     */
    private String type;

    /**
     * 路径
     */
    private String path;

    public Long getDuration() {
        return duration;
    }

    public void setDuration(Long duration) {
        this.duration = duration;
    }

    public Long getSize() {
        return size;
    }

    public void setSize(Long size) {
        this.size = size;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }
}