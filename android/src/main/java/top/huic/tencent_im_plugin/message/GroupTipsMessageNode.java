package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.v2.V2TIMGroupTipsElem;

import top.huic.tencent_im_plugin.message.entity.GroupTipsMessageEntity;

/**
 * 群提示消息节点
 */
public class GroupTipsMessageNode extends AbstractMessageNode<V2TIMGroupTipsElem, GroupTipsMessageEntity> {
    @Override
    public String getNote(V2TIMGroupTipsElem elem) {
        return "[群提示]";
    }

    @Override
    public GroupTipsMessageEntity analysis(V2TIMGroupTipsElem elem) {
        return new GroupTipsMessageEntity(elem);
    }

    @Override
    public Class<GroupTipsMessageEntity> getEntityClass() {
        return GroupTipsMessageEntity.class;
    }
}