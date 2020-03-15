package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMCustomElem;
import com.tencent.imsdk.TIMLocationElem;
import com.tencent.imsdk.TIMMessage;

import java.util.Map;

import top.huic.tencent_im_plugin.ValueCallBack;

/**
 * 位置消息节点
 */
public class LocationMessageNode extends AbstractMessageNode<TIMLocationElem> {
    @Override
    public void send(TIMConversation conversation, Map params, boolean ol, ValueCallBack<TIMMessage> onCallback) {
        TIMMessage message = new TIMMessage();
        TIMLocationElem locationElem = new TIMLocationElem();
        locationElem.setDesc(super.getParam(params, "desc").toString());
        locationElem.setLatitude(Double.parseDouble(super.getParam(params, "latitude").toString()));
        locationElem.setLongitude(Double.parseDouble(super.getParam(params, "longitude").toString()));
        message.addElement(locationElem);
        super.sendMessage(conversation, message, ol, onCallback);
    }

    @Override
    public String getNote(TIMLocationElem elem) {
        return "[位置消息]";
    }
}