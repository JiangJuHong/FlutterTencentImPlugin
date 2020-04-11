package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMImageElem;
import com.tencent.imsdk.TIMMessage;

import top.huic.tencent_im_plugin.message.entity.ImageMessageEntity;

/**
 * 图片消息节点
 */
public class ImageMessageNode extends AbstractMessageNode<TIMImageElem, ImageMessageEntity> {
    @Override
    protected TIMMessage getSendMessage(ImageMessageEntity entity) {
        TIMMessage message = new TIMMessage();
        TIMImageElem imageElem = new TIMImageElem();
        imageElem.setPath(entity.getPath());
        imageElem.setLevel(entity.getLevel());
        message.addElement(imageElem);
        return message;
    }

    @Override
    public String getNote(TIMImageElem elem) {
        return "[图片]";
    }

    @Override
    public ImageMessageEntity analysis(TIMImageElem elem) {
        ImageMessageEntity entity = new ImageMessageEntity();
        entity.setPath(elem.getPath());
        entity.setImageFormat(elem.getImageFormat());
        entity.setLevel(elem.getLevel());
        entity.setImageData(elem.getImageList());
        return entity;
    }

    @Override
    public Class<ImageMessageEntity> getEntityClass() {
        return ImageMessageEntity.class;
    }
}