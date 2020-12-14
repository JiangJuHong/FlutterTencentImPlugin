package top.huic.tencent_im_plugin.entity;

/**
 * 查找消息实体
 */
public class FindMessageEntity {
    /**
     * 消息ID
     */
    private String msgId;

    public FindMessageEntity() {
    }

    public FindMessageEntity(String msgId) {
        this.msgId = msgId;
    }

    public String getMsgId() {
        return msgId;
    }

    public void setMsgId(String msgId) {
        this.msgId = msgId;
    }
}
