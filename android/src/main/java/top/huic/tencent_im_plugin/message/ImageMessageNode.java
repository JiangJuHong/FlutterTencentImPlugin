package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMImage;
import com.tencent.imsdk.TIMImageElem;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMTextElem;

import java.util.Map;

import top.huic.tencent_im_plugin.ValueCallBack;
import top.huic.tencent_im_plugin.message.entity.ImageMessageEntity;

/**
 * 图片消息节点
 */
public class ImageMessageNode extends AbstractMessageNode<TIMImageElem, ImageMessageEntity> {
    @Override
    public void send(TIMConversation conversation, ImageMessageEntity entity, boolean ol, ValueCallBack<TIMMessage> onCallback) {
        TIMMessage message = new TIMMessage();
        TIMImageElem imageElem = new TIMImageElem();
        imageElem.setPath(entity.getPath());
        message.addElement(imageElem);
        super.sendMessage(conversation, message, ol, onCallback);
    }

    @Override
    public String getNote(TIMImageElem elem) {
        return "[图片]";
    }

    @Override
    public Class<ImageMessageEntity> getEntityClass() {
        return ImageMessageEntity.class;
    }
}