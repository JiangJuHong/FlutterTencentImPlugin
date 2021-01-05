package top.huic.tencent_im_plugin.message.entity;

import com.tencent.imsdk.v2.V2TIMFaceElem;

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

    public FaceMessageEntity(V2TIMFaceElem elem) {
        super(MessageNodeType.Face);
        this.setIndex(elem.getIndex());
        this.setData(elem.getData() == null ? null : new String(elem.getData()));
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
