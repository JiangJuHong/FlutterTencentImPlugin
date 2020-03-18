package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.TIMUserProfile;
import com.tencent.imsdk.friendship.TIMFriendPendencyItem;

import java.io.Serializable;

/**
 * 未决实体
 *
 * @author 蒋具宏
 */
public class PendencyEntity implements Serializable {
    /**
     * 用户ID
     */
    private String identifier;
    /**
     * 增加事件
     */
    private long addTime;
    /**
     * 来源
     */
    private String addSource;
    /**
     * 申请说明
     */
    private String addWording;
    /**
     * 好友昵称
     */
    private String nickname;
    /**
     * 未决类型
     */
    private int type;
    /**
     * 用户信息
     */
    private TIMUserProfile userProfile;

    public PendencyEntity() {
    }

    public PendencyEntity(TIMFriendPendencyItem data) {
        identifier = data.getIdentifier();
        addTime = data.getAddTime();
        addSource = data.getAddSource();
        addWording = data.getAddWording();
        nickname = data.getNickname();
        type = data.getType();
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public long getAddTime() {
        return addTime;
    }

    public void setAddTime(long addTime) {
        this.addTime = addTime;
    }

    public String getAddSource() {
        return addSource;
    }

    public void setAddSource(String addSource) {
        this.addSource = addSource;
    }

    public String getAddWording() {
        return addWording;
    }

    public void setAddWording(String addWording) {
        this.addWording = addWording;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public TIMUserProfile getUserProfile() {
        return userProfile;
    }

    public void setUserProfile(TIMUserProfile userProfile) {
        this.userProfile = userProfile;
    }
}