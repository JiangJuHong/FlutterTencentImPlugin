package top.huic.tencent_im_plugin.message.entity;

import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 语音消息实体
 *
 * @author 蒋具宏
 */
public class SoundMessageEntity extends AbstractMessageEntity {

    /**
     * 语音ID
     */
    private String uuid;

    /**
     * 路径
     */
    private String path;

    /**
     * 时长
     */
    private Long duration;

    /**
     * 数据大小
     */
    private Long dataSize;

    public SoundMessageEntity() {
        super(MessageNodeType.Sound);
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Long getDuration() {
        return duration;
    }

    public void setDuration(Long duration) {
        this.duration = duration;
    }

    public Long getDataSize() {
        return dataSize;
    }

    public void setDataSize(Long dataSize) {
        this.dataSize = dataSize;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }
}