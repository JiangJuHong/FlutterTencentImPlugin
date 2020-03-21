package top.huic.tencent_im_plugin.message.entity;

import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 其它消息实体
 *
 * @author 蒋具宏
 */
public class OtherMessageEntity extends AbstractMessageEntity {
    /**
     * 参数信息
     */
    private String params;

    /**
     * 节点
     */
    private String type;

    public OtherMessageEntity() {
        super(MessageNodeType.Other);
    }

    public String getParams() {
        return params;
    }

    public void setParams(String params) {
        this.params = params;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}