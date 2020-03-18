package top.huic.tencent_im_plugin.message.entity;

import java.io.Serializable;

import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 消息实体
 *
 * @author 蒋具宏
 */
public class AbstractMessageEntity implements Serializable {
    private MessageNodeType nodeType;

    public AbstractMessageEntity(MessageNodeType nodeType) {
        this.nodeType = nodeType;
    }

    public MessageNodeType getNodeType() {
        return nodeType;
    }

    public void setNodeType(MessageNodeType nodeType) {
        this.nodeType = nodeType;
    }
}
