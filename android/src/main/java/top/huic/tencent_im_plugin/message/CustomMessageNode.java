package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMCustomElem;
import com.tencent.imsdk.TIMMessage;

import top.huic.tencent_im_plugin.message.entity.CustomMessageEntity;

/**
 * 自定义消息节点
 */
public class CustomMessageNode extends AbstractMessageNode<TIMCustomElem, CustomMessageEntity> {

    @Override
    protected TIMMessage getSendMessage(CustomMessageEntity entity) {
        TIMMessage message = new TIMMessage();
        TIMCustomElem customElem = new TIMCustomElem();
        customElem.setData(entity.getData().getBytes());
        message.addElement(customElem);
        return message;
    }

    @Override
    public String getNote(TIMCustomElem elem) {
        return "[其它消息]";
    }

    @Override
    public CustomMessageEntity analysis(TIMCustomElem elem) {
        CustomMessageEntity entity = new CustomMessageEntity();
        entity.setData(new String((elem.getData())));
        return entity;
    }

    @Override
    public Class<CustomMessageEntity> getEntityClass() {
        return CustomMessageEntity.class;
    }
}