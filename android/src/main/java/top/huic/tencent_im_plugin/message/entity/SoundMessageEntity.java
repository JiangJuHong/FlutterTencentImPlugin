package top.huic.tencent_im_plugin.message.entity;

import com.tencent.imsdk.v2.V2TIMSoundElem;

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
    private Integer duration;

    /**
     * 数据大小
     */
    private Integer dataSize;

    public SoundMessageEntity() {
        super(MessageNodeType.Sound);
    }

    public SoundMessageEntity(V2TIMSoundElem elem) {
        super(MessageNodeType.Sound);
        this.setPath(elem.getPath());
        this.setDuration(elem.getDuration());
        this.setDataSize(elem.getDataSize());
        this.setUuid(elem.getUUID());
    }

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

    public Integer getDataSize() {
        return dataSize;
    }

    public void setDataSize(Integer dataSize) {
        this.dataSize = dataSize;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }
}