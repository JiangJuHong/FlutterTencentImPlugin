package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMGroupTipsElem;
import com.tencent.imsdk.TIMMessage;

import java.util.HashMap;
import java.util.Map;

import top.huic.tencent_im_plugin.ValueCallBack;
import top.huic.tencent_im_plugin.entity.GroupMemberEntity;
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
        GroupTipsMessageEntity entity = new GroupTipsMessageEntity();

        if (elem.getChangedGroupMemberInfo() != null) {
            Map<String, GroupMemberEntity> memberEntityMap = new HashMap<>();
            for (String key : elem.getChangedGroupMemberInfo().keySet()) {
                memberEntityMap.put(key, new GroupMemberEntity(elem.getChangedGroupMemberInfo().get(key)));
            }
            entity.setChangedGroupMemberInfo(memberEntityMap);
        }

        entity.setChangedUserInfo(elem.getChangedUserInfo());
        entity.setGroupId(elem.getGroupId());
        entity.setGroupName(elem.getGroupName());
        entity.setGroupInfoList(elem.getGroupInfoList());
        entity.setMemberInfoList(elem.getMemberInfoList());
        entity.setMemberNum(elem.getMemberNum());
        entity.setOpGroupMemberInfo(elem.getOpGroupMemberInfo());
        entity.setOpUser(elem.getOpUser());
        entity.setOpUserInfo(elem.getOpUserInfo());
        entity.setPlatform(elem.getPlatform());
        entity.setTipsType(elem.getTipsType());
        entity.setUserList(elem.getUserList());
        return entity;
    }

    @Override
    public Class<GroupTipsMessageEntity> getEntityClass() {
        return GroupTipsMessageEntity.class;
    }
}