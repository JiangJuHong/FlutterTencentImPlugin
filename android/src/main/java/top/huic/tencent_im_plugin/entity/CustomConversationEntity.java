package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.v2.V2TIMConversation;
import com.tencent.imsdk.v2.V2TIMGroupAtInfo;

import java.util.List;

import top.huic.tencent_im_plugin.util.BeanUtils;

/**
 * 自定义会话实体
 */
public class CustomConversationEntity {

    /**
     * 会话ID
     */
    String conversationID;

    /**
     * 会话类型
     */
    int type;

    /**
     * 用户ID
     */
    String userID;

    /**
     * 群ID
     */
    String groupID;

    /**
     * 显示名称
     */
    String showName;

    /**
     * 头像
     */
    String faceUrl;

    /**
     * 接收消息选项（群会话有效）
     */
    int recvOpt;

    /**
     * 群类型
     */
    String groupType;

    /**
     * 未读数量
     */
    int unreadCount;

    /**
     * 最后一条消息
     */
    CustomMessageEntity lastMessage;

    /**
     * 草稿文本
     */
    String draftText;

    /**
     * 草稿时间
     */
    Long draftTimestamp;

    /**
     * \@信息列表
     */
    List<V2TIMGroupAtInfo> groupAtInfoList;

    public CustomConversationEntity() {
    }

    public CustomConversationEntity(V2TIMConversation data) {
        BeanUtils.copyProperties(data, this, "lastMessage");
        if (data.getLastMessage() != null) {
            this.lastMessage = new CustomMessageEntity(data.getLastMessage());
        }
    }

    public String getConversationID() {
        return conversationID;
    }

    public void setConversationID(String conversationID) {
        this.conversationID = conversationID;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getGroupID() {
        return groupID;
    }

    public void setGroupID(String groupID) {
        this.groupID = groupID;
    }

    public String getShowName() {
        return showName;
    }

    public void setShowName(String showName) {
        this.showName = showName;
    }

    public String getFaceUrl() {
        return faceUrl;
    }

    public void setFaceUrl(String faceUrl) {
        this.faceUrl = faceUrl;
    }

    public int getRecvOpt() {
        return recvOpt;
    }

    public void setRecvOpt(int recvOpt) {
        this.recvOpt = recvOpt;
    }

    public String getGroupType() {
        return groupType;
    }

    public void setGroupType(String groupType) {
        this.groupType = groupType;
    }

    public int getUnreadCount() {
        return unreadCount;
    }

    public void setUnreadCount(int unreadCount) {
        this.unreadCount = unreadCount;
    }

    public CustomMessageEntity getLastMessage() {
        return lastMessage;
    }

    public void setLastMessage(CustomMessageEntity lastMessage) {
        this.lastMessage = lastMessage;
    }

    public String getDraftText() {
        return draftText;
    }

    public void setDraftText(String draftText) {
        this.draftText = draftText;
    }

    public Long getDraftTimestamp() {
        return draftTimestamp;
    }

    public void setDraftTimestamp(Long draftTimestamp) {
        this.draftTimestamp = draftTimestamp;
    }

    public List<V2TIMGroupAtInfo> getGroupAtInfoList() {
        return groupAtInfoList;
    }

    public void setGroupAtInfoList(List<V2TIMGroupAtInfo> groupAtInfoList) {
        this.groupAtInfoList = groupAtInfoList;
    }
}
