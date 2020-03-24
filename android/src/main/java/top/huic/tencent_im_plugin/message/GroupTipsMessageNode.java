package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMGroupTipsElem;
import com.tencent.imsdk.TIMMessage;

import top.huic.tencent_im_plugin.ValueCallBack;
import top.huic.tencent_im_plugin.message.entity.GroupTipsMessageEntity;

/**
 * 群提示消息节点
 */
public class GroupTipsMessageNode extends AbstractMessageNode<TIMGroupTipsElem, GroupTipsMessageEntity> {
    @Override
    public void send(TIMConversation conversation, GroupTipsMessageEntity entity, boolean ol, ValueCallBack<TIMMessage> onCallback) {
        throw new RuntimeException("This node does not support sending");
    }

    @Override
    public String getNote(TIMGroupTipsElem elem) {
        return "[群提示消息]";
    }

    @Override
    public GroupTipsMessageEntity analysis(TIMGroupTipsElem elem) {
        return new GroupTipsMessageEntity(elem);
    }

    @Override
    public Class<GroupTipsMessageEntity> getEntityClass() {
        return GroupTipsMessageEntity.class;
    }
}