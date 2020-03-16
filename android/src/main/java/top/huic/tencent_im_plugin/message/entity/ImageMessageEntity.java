package top.huic.tencent_im_plugin.message.entity;

import com.tencent.imsdk.TIMImage;

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
     * 图片类型
     */
    private Integer imageFormat;

    /**
     * 图片质量
     */
    private Integer level;

    /**
     * 图片列表，根据类型分开
     */
    private List<TIMImage> imageData;

    public ImageMessageEntity() {
        super(MessageNodeType.Image);
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public Integer getImageFormat() {
        return imageFormat;
    }

    public void setImageFormat(Integer imageFormat) {
        this.imageFormat = imageFormat;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public List<TIMImage> getImageData() {
        return imageData;
    }

    public void setImageData(List<TIMImage> imageData) {
        this.imageData = imageData;
    }
}