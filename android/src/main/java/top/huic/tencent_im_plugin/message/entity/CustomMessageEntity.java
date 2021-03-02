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

    /**
     * 描述
     */
    private String desc;

    /**
     * 扩展内容
     */
    private String ext;

    public CustomMessageEntity() {
        super(MessageNodeType.Custom);
    }

    public CustomMessageEntity(V2TIMCustomElem elem) {
        super(MessageNodeType.Custom);
        this.data = new String(elem.getData());
        this.desc = elem.getDescription();
        this.ext = new String(elem.getExtension());
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public String getExt() {
        return ext;
    }

    public void setExt(String ext) {
        this.ext = ext;
    }
}