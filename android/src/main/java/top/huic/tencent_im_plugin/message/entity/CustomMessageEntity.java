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

    private String ext;

    private String desc;

    public CustomMessageEntity() {
        super(MessageNodeType.Custom);
    }

    public CustomMessageEntity(V2TIMCustomElem elem) {
        super(MessageNodeType.Custom);
        this.data = new String(elem.getData());
        this.ext = new String(elem.getExtension());
        this.desc = elem.getDescription();
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getExt() {
        return ext;
    }

    public void setExt(String ext) {
        this.ext = ext;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}