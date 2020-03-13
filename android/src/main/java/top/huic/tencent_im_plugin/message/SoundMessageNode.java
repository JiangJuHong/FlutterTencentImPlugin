package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMSnapshot;
import com.tencent.imsdk.TIMSoundElem;
import com.tencent.imsdk.TIMVideo;
import com.tencent.imsdk.TIMVideoElem;

import java.util.Map;

import top.huic.tencent_im_plugin.ValueCallBack;

/**
 * 语音消息节点
 */
public class SoundMessageNode extends AbstractMessageNode<TIMSoundElem> {
    @Override
    public void send(TIMConversation conversation, Map params, boolean ol, ValueCallBack<TIMMessage> onCallback) {
        TIMMessage message = new TIMMessage();
        TIMSoundElem soundElem = new TIMSoundElem();
        soundElem.setPath(super.getParam(params, "type").toString());
        soundElem.setDuration(Integer.parseInt(super.getParam(params, "duration").toString()));
        message.addElement(soundElem);
        super.sendMessage(conversation, message, ol, onCallback);
    }

    @Override
    public String getNote(TIMSoundElem elem) {
        return "[语音]";
    }
}