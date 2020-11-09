package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.v2.V2TIMImageElem;
import com.tencent.imsdk.v2.V2TIMManager;
import com.tencent.imsdk.v2.V2TIMMessage;

import top.huic.tencent_im_plugin.message.entity.ImageMessageEntity;

/**
 * 图片消息节点
 */
public class ImageMessageNode extends AbstractMessageNode<V2TIMImageElem, ImageMessageEntity> {
    @Override
    public V2TIMMessage getV2TIMMessage(ImageMessageEntity entity) {
        return V2TIMManager.getMessageManager().createImageMessage(entity.getPath());
    }

    @Override
    public String getNote(V2TIMImageElem elem) {
        return "[图片]";
    }

    @Override
    public ImageMessageEntity analysis(V2TIMImageElem elem) {
        ImageMessageEntity entity = new ImageMessageEntity();
        entity.setPath(elem.getPath());
        entity.setImageData(elem.getImageList());
        return entity;
    }

    @Override
    public Class<ImageMessageEntity> getEntityClass() {
        return ImageMessageEntity.class;
    }
}