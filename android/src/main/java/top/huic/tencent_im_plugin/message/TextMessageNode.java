package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMTextElem;

import java.util.Map;

import top.huic.tencent_im_plugin.ValueCallBack;

/**
 * 文本消息节点
 */
public class TextMessageNode extends AbstractMessageNode<TIMTextElem> {
    @Override
    public void send(TIMConversation conversation, Map params, boolean ol, ValueCallBack<TIMMessage> onCallback) {
        TIMMessage message = new TIMMessage();
        TIMTextElem textElem = new TIMTextElem();
        textElem.setText(super.getParam(params, "content").toString());
        message.addElement(textElem);
        super.sendMessage(conversation, message, ol, onCallback);
    }

    @Override
    public String getNote(TIMTextElem elem) {
        return elem.getText();
    }
}