package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.v2.V2TIMManager;
import com.tencent.imsdk.v2.V2TIMMessage;
import com.tencent.imsdk.v2.V2TIMTextElem;

import top.huic.tencent_im_plugin.message.entity.TextMessageEntity;

/**
 * 文本消息节点
 */
public class TextMessageNode extends AbstractMessageNode<V2TIMTextElem, TextMessageEntity> {
    @Override
    public V2TIMMessage getV2TIMMessage(TextMessageEntity entity) {
        if (entity.getAtUserList() != null && entity.getAtUserList().size() >= 1) {
            return V2TIMManager.getMessageManager().createTextAtMessage(entity.getContent(), entity.getAtUserList());
        }
        return V2TIMManager.getMessageManager().createTextMessage(entity.getContent());
    }

    @Override
    public String getNote(V2TIMTextElem elem) {
        return elem.getText();
    }

    @Override
    public TextMessageEntity analysis(V2TIMTextElem elem) {
        TextMessageEntity entity = new TextMessageEntity();
        entity.setContent(elem.getText());
        return entity;
    }

    @Override
    public Class<TextMessageEntity> getEntityClass() {
        return TextMessageEntity.class;
    }
}