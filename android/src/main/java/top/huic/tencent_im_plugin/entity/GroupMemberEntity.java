package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.TIMGroupMemberInfo;
import com.tencent.imsdk.TIMUserProfile;

import java.io.Serializable;

/**
 * 群成员实体
 *
 * @author 蒋具宏
 */
public class GroupMemberEntity implements Serializable {
    /**
     * 加群时间
     */
    private long joinTime;

    /**
     * 群名片
     */
    private String nameCard;

    /**
     * 角色
     */
    private int role;

    /**
     * 禁言结束时间
     */
    private long silenceSeconds;

    private long msgFlag;

    private long msgSeq;

    private long tinyId;

    /**
     * 用户账号
     */
    private String user;

    /**
     * 用户账号信息
     */
    private TIMUserProfile userProfile;

    public GroupMemberEntity(TIMGroupMemberInfo data) {
        this.joinTime = data.getJoinTime();
        this.nameCard = data.getNameCard();
        this.role = data.getRole();
        this.silenceSeconds = data.getSilenceSeconds();
        this.msgFlag = data.getMsgFlag();
        this.msgSeq = data.getMsgSeq();
        this.tinyId = data.getTinyId();
        this.user = data.getUser();
    }

    public long getJoinTime() {
        return joinTime;
    }

    public void setJoinTime(long joinTime) {
        this.joinTime = joinTime;
    }

    public String getNameCard() {
        return nameCard;
    }

    public void setNameCard(String nameCard) {
        this.nameCard = nameCard;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public long getSilenceSeconds() {
        return silenceSeconds;
    }

    public void setSilenceSeconds(long silenceSeconds) {
        this.silenceSeconds = silenceSeconds;
    }

    public long getMsgFlag() {
        return msgFlag;
    }

    public void setMsgFlag(long msgFlag) {
        this.msgFlag = msgFlag;
    }

    public long getMsgSeq() {
        return msgSeq;
    }

    public void setMsgSeq(long msgSeq) {
        this.msgSeq = msgSeq;
    }

    public long getTinyId() {
        return tinyId;
    }

    public void setTinyId(long tinyId) {
        this.tinyId = tinyId;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public TIMUserProfile getUserProfile() {
        return userProfile;
    }

    public void setUserProfile(TIMUserProfile userProfile) {
        this.userProfile = userProfile;
    }
}
