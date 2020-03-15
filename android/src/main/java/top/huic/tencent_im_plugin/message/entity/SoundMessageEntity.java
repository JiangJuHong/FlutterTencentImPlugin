package top.huic.tencent_im_plugin.message.entity;

/**
 * 语音消息实体
 *
 * @author 蒋具宏
 */
public class SoundMessageEntity {
    /**
     * 路径
     */
    private String path;

    /**
     * 时长
     */
    private Integer duration;

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
}