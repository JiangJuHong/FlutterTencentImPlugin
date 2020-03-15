package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMTextElem;

import top.huic.tencent_im_plugin.ValueCallBack;
import top.huic.tencent_im_plugin.message.entity.TextMessageEntity;

/**
 * 文本消息节点
 */
public class TextMessageNode extends AbstractMessageNode<TIMTextElem, TextMessageEntity> {
    @Override
    public void send(TIMConversation conversation, TextMessageEntity entity, boolean ol, ValueCallBack<TIMMessage> onCallback) {
        TIMMessage message = new TIMMessage();
        TIMTextElem textElem = new TIMTextElem();
        textElem.setText(entity.getContent());
        message.addElement(textElem);
        super.sendMessage(conversation, message, ol, onCallback);
    }

    @Override
    public String getNote(TIMTextElem elem) {
        return elem.getText();
    }

    @Override
    public Class<TextMessageEntity> getEntityClass() {
        return TextMessageEntity.class;
    }
}