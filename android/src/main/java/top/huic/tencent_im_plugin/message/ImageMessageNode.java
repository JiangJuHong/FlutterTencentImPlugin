package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMImage;
import com.tencent.imsdk.TIMImageElem;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMTextElem;

import java.util.Map;

import top.huic.tencent_im_plugin.ValueCallBack;

/**
 * 图片消息节点
 */
public class ImageMessageNode extends AbstractMessageNode<TIMImageElem> {
    @Override
    public void send(TIMConversation conversation, Map params, boolean ol, ValueCallBack<TIMMessage> onCallback) {
        TIMMessage message = new TIMMessage();
        TIMImageElem imageElem = new TIMImageElem();
        imageElem.setPath(super.getParam(params, "path").toString());
        message.addElement(imageElem);
        super.sendMessage(conversation, message, ol, onCallback);
    }

    @Override
    public String getNote(TIMImageElem elem) {
        return "[图片]";
    }
}