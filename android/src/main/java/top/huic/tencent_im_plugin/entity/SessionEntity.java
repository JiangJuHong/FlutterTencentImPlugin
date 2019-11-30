package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.TIMConversationType;

/**
 * 会话对象
 *
 * @author 蒋具宏
 */
public class SessionEntity {
    /**
     * 会话 ID
     */
    private String id;

    /**
     * 会话名，如果是用户则为用户昵称，如果是群则为群昵称
     */
    private String nickname;

    /**
     * 会话类型
     */
    private TIMConversationType type;

    /**
     * 头像(用户头像、群头像、系统头像)
     */
    private String faceUrl;

    /**
     * 未读消息数量
     */
    private long unreadMessageNum;

    /**
     * 最近一条消息
     */
    private MessageEntity message;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public SessionEntity() {
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getFaceUrl() {
        return faceUrl;
    }

    public void setFaceUrl(String faceUrl) {
        this.faceUrl = faceUrl;
    }

    public TIMConversationType getType() {
        return type;
    }

    public void setType(TIMConversationType type) {
        this.type = type;
    }

    public long getUnreadMessageNum() {
        return unreadMessageNum;
    }

    public void setUnreadMessageNum(long unreadMessageNum) {
        this.unreadMessageNum = unreadMessageNum;
    }

    public MessageEntity getMessage() {
        return message;
    }

    public void setMessage(MessageEntity message) {
        this.message = message;
    }
}