package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMSNSSystemElem;

import top.huic.tencent_im_plugin.message.entity.SnsTipsMessageEntity;

/**
 * 关系链相关操作后，后台push同步下来的消息元素
 */
public class SnsTipsMessageNode extends AbstractMessageNode<TIMSNSSystemElem, SnsTipsMessageEntity> {
    @Override
    protected TIMMessage getSendMessage(SnsTipsMessageEntity entity) {
        throw new RuntimeException("This node does not support sending");
    }

    @Override
    public String getNote(TIMSNSSystemElem elem) {
        return "[关系链变更消息]";
    }

    @Override
    public SnsTipsMessageEntity analysis(TIMSNSSystemElem elem) {
        return new SnsTipsMessageEntity(elem);
    }

    @Override
    public Class<SnsTipsMessageEntity> getEntityClass() {
        return SnsTipsMessageEntity.class;
    }
}