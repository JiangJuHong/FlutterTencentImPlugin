package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMCustomElem;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMTextElem;

import java.util.Map;

import top.huic.tencent_im_plugin.ValueCallBack;

/**
 * 自定义消息节点
 */
public class CustomMessageNode extends AbstractMessageNode<TIMCustomElem> {
    @Override
    public void send(TIMConversation conversation, Map params, boolean ol, ValueCallBack<TIMMessage> onCallback) {
        TIMMessage message = new TIMMessage();
        TIMCustomElem customElem = new TIMCustomElem();
        customElem.setData(super.getParam(params, "data").toString().getBytes());
        message.addElement(customElem);
        super.sendMessage(conversation, message, ol, onCallback);
    }

    @Override
    public String getNote(TIMCustomElem elem) {
        return "[其它消息]";
    }
}