package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMGroupSystemElem;
import com.tencent.imsdk.TIMMessage;
import top.huic.tencent_im_plugin.message.entity.GroupSystemEntity;


public class GroupSystemMessageNode extends AbstractMessageNode<TIMGroupSystemElem, GroupSystemEntity> {
    @Override
    protected TIMMessage getSendMessage(GroupSystemEntity entity) {
        throw new RuntimeException("This node does not support sending");
    }

    @Override
    public String getNote(TIMGroupSystemElem elem) {
        return "[群系统消息]";
    }

    @Override
    public GroupSystemEntity analysis(TIMGroupSystemElem elem) {
        return new GroupSystemEntity(elem);
    }

    @Override
    public Class<GroupSystemEntity> getEntityClass() {
        return GroupSystemEntity.class;
    }
}
