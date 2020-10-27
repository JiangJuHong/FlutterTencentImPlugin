package top.huic.tencent_im_plugin.message.entity;

import com.tencent.imsdk.v2.V2TIMCustomElem;

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

    public CustomMessageEntity(V2TIMCustomElem elem) {
        super(MessageNodeType.Custom);
        this.data = new String(elem.getData());
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }
}