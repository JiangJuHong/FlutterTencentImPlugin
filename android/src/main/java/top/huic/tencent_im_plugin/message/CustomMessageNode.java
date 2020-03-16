package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMCustomElem;
import com.tencent.imsdk.TIMMessage;

import top.huic.tencent_im_plugin.ValueCallBack;
import top.huic.tencent_im_plugin.message.entity.CustomMessageEntity;

/**
 * 自定义消息节点
 */
public class CustomMessageNode extends AbstractMessageNode<TIMCustomElem, CustomMessageEntity> {
    @Override
    public void send(TIMConversation conversation, CustomMessageEntity entity, boolean ol, ValueCallBack<TIMMessage> onCallback) {
        TIMMessage message = new TIMMessage();
        TIMCustomElem customElem = new TIMCustomElem();
        customElem.setData(entity.getData().getBytes());
        message.addElement(customElem);
        super.sendMessage(conversation, message, ol, onCallback);
    }

    @Override
    public String getNote(TIMCustomElem elem) {
        return "[其它消息]";
    }

    @Override
    public CustomMessageEntity analysis(TIMCustomElem elem) {
        CustomMessageEntity entity = new CustomMessageEntity();
        elem.setData(elem.getData());
        return entity;
    }

    @Override
    public Class<CustomMessageEntity> getEntityClass() {
        return CustomMessageEntity.class;
    }
}