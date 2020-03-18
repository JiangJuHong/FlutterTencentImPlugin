package top.huic.tencent_im_plugin.message.entity.video;

import java.io.Serializable;

/**
 * 视频缩略图信息
 *
 * @author 蒋具宏
 */
public class VideoSnapshotInfo implements Serializable {
    /**
     * 图片ID
     */
    private String uuid;

    /**
     * 图片大小
     */
    private Long size;

    /**
     * 图片宽度
     */
    private Long width;

    /**
     * 图片类型
     */
    private String type;

    /**
     * 图片高度
     */
    private Long height;

    /**
     * 路径
     */
    private String path;

    public Long getSize() {
        return size;
    }

    public void setSize(Long size) {
        this.size = size;
    }

    public Long getWidth() {
        return width;
    }

    public void setWidth(Long width) {
        this.width = width;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Long getHeight() {
        return height;
    }

    public void setHeight(Long height) {
        this.height = height;
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