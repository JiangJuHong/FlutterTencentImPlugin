package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.TIMConversationType;
import com.tencent.imsdk.TIMElem;
import com.tencent.imsdk.TIMGroupMemberInfo;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMMessageStatus;
import com.tencent.imsdk.TIMUserProfile;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import top.huic.tencent_im_plugin.enums.MessageNodeType;
import top.huic.tencent_im_plugin.message.entity.AbstractMessageEntity;

/**
 * 消息实体
 *
 * @author 蒋具宏
 */
public class MessageEntity  implements Serializable {
    /**
     * 消息ID
     */
    private String id;

    /**
     * 消息随机码
     */
    private Long rand;

    /**
     * 消息序列号
     */
    private Long seq;

    /**
     * 唯一ID
     */
    private Long uniqueId;

    /**
     * 对方是否已读
     */
    private Boolean peerReaded;

    /**
     * 自己是否已读
     */
    private Boolean read;

    /**
     * 当前登录用户是否是发送方
     */
    private Boolean self;

    /**
     * 自定义整数
     */
    private Integer customInt;

    /**
     * 自定义值
     */
    private String customStr;

    /**
     * 消息时间戳
     */
    private Long timestamp;

    /**
     * 消息发送方
     */
    private String sender;

    /**
     * 会话ID
     */
    private String sessionId;

    /**
     * 发送人->用户信息
     */
    private TIMUserProfile userInfo;

    /**
     * 发送人->群成员信息
     */
    private TIMGroupMemberInfo groupMemberInfo;

    /**
     * 节点内容
     */
    private List<AbstractMessageEntity> elemList;

    /**
     * 消息状态
     */
    private TIMMessageStatus status;

    /**
     * 会话类型
     */
    private TIMConversationType sessionType;

    /**
     * 描述，根据节点内容自定义描述信息，例如文本会直接包含，图片则为: [图片]
     * 注意：如果有多个 elem，将只返回第一个节点的内容
     */
    private String note;

    public MessageEntity() {
    }

    public MessageEntity(TIMMessage message) {
        this.rand = message.getRand();
        this.seq = message.getSeq();
        this.id = message.getMsgId();
        this.uniqueId = message.getMsgUniqueId();
        this.peerReaded = message.isPeerReaded();
        this.read = message.isRead();
        this.self = message.isSelf();
        this.customInt = message.getCustomInt();
        this.customStr = message.getCustomStr();
        this.timestamp = message.timestamp();

        this.elemList = new ArrayList<>(message.getElementCount());
        for (int i = 0; i < message.getElementCount(); i++) {
            TIMElem elem = message.getElement(i);
            elemList.add(MessageNodeType.getTypeByTIMElemType(message.getElement(0).getType()).getMessageNodeInterface().analysis(elem));
        }

        this.groupMemberInfo = message.getSenderGroupMemberProfile();
        this.sender = message.getSender();
        this.sessionId = message.getConversation().getPeer();
        this.status = message.status();
        this.sessionType = message.getConversation().getType();
        if (message.getElementCount() >= 1) {
            this.note = MessageNodeType.getTypeByTIMElemType(message.getElement(0).getType()).getMessageNodeInterface().getNote(message.getElement(0));
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Long getUniqueId() {
        return uniqueId;
    }

    public void setUniqueId(Long uniqueId) {
        this.uniqueId = uniqueId;
    }

    public Boolean getPeerReaded() {
        return peerReaded;
    }

    public void setPeerReaded(Boolean peerReaded) {
        this.peerReaded = peerReaded;
    }

    public Boolean getRead() {
        return read;
    }

    public void setRead(Boolean read) {
        this.read = read;
    }

    public Boolean getSelf() {
        return self;
    }

    public void setSelf(Boolean self) {
        this.self = self;
    }

    public Integer getCustomInt() {
        return customInt;
    }

    public void setCustomInt(Integer customInt) {
        this.customInt = customInt;
    }

    public String getCustomStr() {
        return customStr;
    }

    public void setCustomStr(String customStr) {
        this.customStr = customStr;
    }

    public Long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Long timestamp) {
        this.timestamp = timestamp;
    }

    public TIMUserProfile getUserInfo() {
        return userInfo;
    }

    public void setUserInfo(TIMUserProfile userInfo) {
        this.userInfo = userInfo;
    }

    public TIMGroupMemberInfo getGroupMemberInfo() {
        return groupMemberInfo;
    }

    public void setGroupMemberInfo(TIMGroupMemberInfo groupMemberInfo) {
        this.groupMemberInfo = groupMemberInfo;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public TIMMessageStatus getStatus() {
        return status;
    }

    public void setStatus(TIMMessageStatus status) {
        this.status = status;
    }

    public TIMConversationType getSessionType() {
        return sessionType;
    }

    public void setSessionType(TIMConversationType sessionType) {
        this.sessionType = sessionType;
    }

    public Long getRand() {
        return rand;
    }

    public void setRand(Long rand) {
        this.rand = rand;
    }

    public Long getSeq() {
        return seq;
    }

    public void setSeq(Long seq) {
        this.seq = seq;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public List<AbstractMessageEntity> getElemList() {
        return elemList;
    }

    public void setElemList(List<AbstractMessageEntity> elemList) {
        this.elemList = elemList;
    }
}
