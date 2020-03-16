package top.huic.tencent_im_plugin.message.entity;

import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 文本消息实体
 *
 * @author 蒋具宏
 */
public class TextMessageEntity extends AbstractMessageEntity {
    /**
     * 消息内容
     */
    private String content;

    public TextMessageEntity() {
        super(MessageNodeType.Text);
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}