package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.v2.V2TIMManager;
import com.tencent.imsdk.v2.V2TIMMessage;
import com.tencent.imsdk.v2.V2TIMSoundElem;

import top.huic.tencent_im_plugin.message.entity.SoundMessageEntity;

/**
 * 语音消息节点
 */
public class SoundMessageNode extends AbstractMessageNode<V2TIMSoundElem, SoundMessageEntity> {

    @Override
    public V2TIMMessage getV2TIMMessage(SoundMessageEntity entity) {
        return V2TIMManager.getMessageManager().createSoundMessage(entity.getPath(), entity.getDuration());
    }

    @Override
    public String getNote(V2TIMSoundElem elem) {
        return "[语音]";
    }

    @Override
    public SoundMessageEntity analysis(V2TIMSoundElem elem) {
        return new SoundMessageEntity(elem);
    }

    @Override
    public Class<SoundMessageEntity> getEntityClass() {
        return SoundMessageEntity.class;
    }
}