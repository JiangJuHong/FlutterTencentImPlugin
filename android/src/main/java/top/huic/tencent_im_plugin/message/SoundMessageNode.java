package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMSoundElem;

import top.huic.tencent_im_plugin.ValueCallBack;
import top.huic.tencent_im_plugin.message.entity.SoundMessageEntity;

/**
 * 语音消息节点
 */
public class SoundMessageNode extends AbstractMessageNode<TIMSoundElem, SoundMessageEntity> {
    @Override
    public void send(TIMConversation conversation, SoundMessageEntity entity, boolean ol, ValueCallBack<TIMMessage> onCallback) {
        TIMMessage message = new TIMMessage();
        TIMSoundElem soundElem = new TIMSoundElem();
        soundElem.setPath(entity.getPath());
        soundElem.setDuration(entity.getDuration());
        message.addElement(soundElem);
        super.sendMessage(conversation, message, ol, onCallback);
    }

    @Override
    public String getNote(TIMSoundElem elem) {
        return "[语音]";
    }

    @Override
    public SoundMessageEntity analysis(TIMSoundElem elem) {
        SoundMessageEntity entity = new SoundMessageEntity();
        entity.setPath(elem.getPath());
        entity.setDuration(elem.getDuration());
        entity.setDataSize(elem.getDataSize());
        entity.setUuid(elem.getUuid());
        return entity;
    }

    @Override
    public Class<SoundMessageEntity> getEntityClass() {
        return SoundMessageEntity.class;
    }
}