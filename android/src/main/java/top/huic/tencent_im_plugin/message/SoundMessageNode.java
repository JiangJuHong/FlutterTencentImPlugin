package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMSoundElem;

import top.huic.tencent_im_plugin.message.entity.SoundMessageEntity;

/**
 * 语音消息节点
 */
public class SoundMessageNode extends AbstractMessageNode<TIMSoundElem, SoundMessageEntity> {
    @Override
    protected TIMMessage getSendMessage(SoundMessageEntity entity) {
        TIMMessage message = new TIMMessage();
        TIMSoundElem soundElem = new TIMSoundElem();
        soundElem.setPath(entity.getPath());
        soundElem.setDuration(entity.getDuration());
        message.addElement(soundElem);
        return message;
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