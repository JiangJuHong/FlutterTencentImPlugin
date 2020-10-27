package top.huic.tencent_im_plugin.message.entity;

import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 表情消息实体
 */
public class FaceMessageEntity extends AbstractMessageEntity {

    /**
     * 索引
     */
    private int index;

    /**
     * 数据
     */
    private String data;


    public FaceMessageEntity() {
        super(MessageNodeType.Face);
    }

    public int getIndex() {
        return index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }
}
