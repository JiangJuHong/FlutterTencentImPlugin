package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMTextElem;

import top.huic.tencent_im_plugin.message.entity.TextMessageEntity;

/**
 * 文本消息节点
 */
public class TextMessageNode extends AbstractMessageNode<TIMTextElem, TextMessageEntity> {
    @Override
    protected TIMMessage getSendMessage(TextMessageEntity entity) {
        TIMMessage message = new TIMMessage();
        TIMTextElem textElem = new TIMTextElem();
        textElem.setText(entity.getContent());
        message.addElement(textElem);
        return message;
    }

    @Override
    public String getNote(TIMTextElem elem) {
        return elem.getText();
    }

    @Override
    public TextMessageEntity analysis(TIMTextElem elem) {
        TextMessageEntity entity = new TextMessageEntity();
        entity.setContent(elem.getText());
        return entity;
    }

    @Override
    public Class<TextMessageEntity> getEntityClass() {
        return TextMessageEntity.class;
    }
}