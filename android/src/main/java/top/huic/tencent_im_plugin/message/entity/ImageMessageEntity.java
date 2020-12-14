package top.huic.tencent_im_plugin.message.entity;

import com.tencent.imsdk.v2.V2TIMImageElem;

import java.util.List;

import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 图片消息实体
 *
 * @author 蒋具宏
 */
public class ImageMessageEntity extends AbstractMessageEntity {
    /**
     * 原图本地文件路径，发送方有效
     */
    private String path;

    /**
     * 图片列表，根据类型分开
     */
    private List<V2TIMImageElem.V2TIMImage> imageData;

    public ImageMessageEntity() {
        super(MessageNodeType.Image);
    }

    public ImageMessageEntity(V2TIMImageElem elem) {
        super(MessageNodeType.Image);
        this.setPath(elem.getPath());
        this.setImageData(elem.getImageList());
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public List<V2TIMImageElem.V2TIMImage> getImageData() {
        return imageData;
    }

    public void setImageData(List<V2TIMImageElem.V2TIMImage> imageData) {
        this.imageData = imageData;
    }
}