package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.TIMGroupMemberInfo;

import java.util.Map;

/**
 * 群成员信息实体，继承自{@link TIMGroupMemberInfo}，解决 fastjson 无法序列化填充问题
 * @author 蒋具宏
 */
public class GroupMemberInfo extends TIMGroupMemberInfo {
    @Override
    public void setJoinTime(long joinTime) {
        super.setJoinTime(joinTime);
    }

    @Override
    public void setRole(int role) {
        super.setRole(role);
    }

    @Override
    public void setUser(String identifier) {
        super.setUser(identifier);
    }

    @Override
    public void setNameCard(String nameCard) {
        super.setNameCard(nameCard);
    }

    @Override
    public void setCustomInfo(Map<String, byte[]> customInfo) {
        super.setCustomInfo(customInfo);
    }

    @Override
    public void setSilenceSeconds(long seconds) {
        super.setSilenceSeconds(seconds);
    }

    @Override
    public void setTinyId(long tinyId) {
        super.setTinyId(tinyId);
    }

    @Override
    public void setMsgFlag(long msgFlag) {
        super.setMsgFlag(msgFlag);
    }

    @Override
    public void setMsgSeq(long msgSeq) {
        super.setMsgSeq(msgSeq);
    }
}
