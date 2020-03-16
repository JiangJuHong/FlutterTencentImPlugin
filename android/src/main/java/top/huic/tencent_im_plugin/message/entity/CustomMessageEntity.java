package top.huic.tencent_im_plugin.message.entity;

import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 自定义消息实体
 *
 * @author 蒋具宏
 */
public class CustomMessageEntity extends AbstractMessageEntity {
    /**
     * 自定义内容
     */
    private String data;

    public CustomMessageEntity() {
        super(MessageNodeType.Custom);
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }
}