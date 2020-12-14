package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.v2.V2TIMCustomElem;
import com.tencent.imsdk.v2.V2TIMManager;
import com.tencent.imsdk.v2.V2TIMMessage;

import top.huic.tencent_im_plugin.message.entity.CustomMessageEntity;

/**
 * 自定义消息节点
 */
public class CustomMessageNode extends AbstractMessageNode<V2TIMCustomElem, CustomMessageEntity> {

    @Override
    public V2TIMMessage getV2TIMMessage(CustomMessageEntity entity) {
        return V2TIMManager.getMessageManager().createCustomMessage(entity.getData().getBytes());
    }

    @Override
    public String getNote(V2TIMCustomElem elem) {
        return "[其它消息]";
    }

    @Override
    public CustomMessageEntity analysis(V2TIMCustomElem elem) {
        return new CustomMessageEntity(elem);
    }

    @Override
    public Class<CustomMessageEntity> getEntityClass() {
        return CustomMessageEntity.class;
    }
}