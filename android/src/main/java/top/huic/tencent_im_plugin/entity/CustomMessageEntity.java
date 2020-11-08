package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.v2.V2TIMElem;
import com.tencent.imsdk.v2.V2TIMMessage;
import com.tencent.imsdk.v2.V2TIMOfflinePushInfo;

import java.io.Serializable;
import java.util.List;

import top.huic.tencent_im_plugin.enums.MessageNodeType;
import top.huic.tencent_im_plugin.message.AbstractMessageNode;
import top.huic.tencent_im_plugin.message.entity.AbstractMessageEntity;
import top.huic.tencent_im_plugin.util.BeanUtils;

/**
 * 自定义消息实体
 *
 * @author 蒋具宏
 */
public class CustomMessageEntity implements Serializable {

    /**
     * 消息 ID
     */
    private String msgID;

    /**
     * 消息时间戳
     */
    private Long timestamp;

    /**
     * 消息发送者 userID
     */
    private String sender;

    /**
     * 消息发送者昵称
     */
    private String nickName;

    /**
     * 好友备注。如果没有拉取过好友信息或者不是好友，返回 null
     */
    private String friendRemark;

    /**
     * 发送者头像 url
     */
    private String faceUrl;

    /**
     * 群组消息，nameCard 为发送者的群名片
     */
    private String nameCard;

    /**
     * 群组消息，groupID 为接收消息的群组 ID，否则为 null
     */
    private String groupID;

    /**
     * 单聊消息，userID 为会话用户 ID，否则为 null。 假设自己和 userA 聊天，无论是自己发给 userA 的消息还是 userA 发给自己的消息，这里的 userID 均为 userA
     */
    private String userID;

    /**
     * 消息发送状态
     */
    private Integer status;

    /**
     * 消息类型
     */
    private Integer elemType;

    /**
     * 消息自定义数据（本地保存，不会发送到对端，程序卸载重装后失效）
     */
    private String localCustomData;

    /**
     * 消息自定义数据（本地保存，不会发送到对端，程序卸载重装后失效）
     */
    private Integer localCustomInt;

    /**
     * 消息发送者是否是自己
     */
    private Boolean self;

    /**
     * 消息自己是否已读
     */
    private Boolean read;

    /**
     * 消息对方是否已读（只有 C2C 消息有效）
     */
    private Boolean peerRead;

    /**
     * 消息优先级
     */
    private Integer priority;

    /**
     * 消息的离线推送信息
     */
    private V2TIMOfflinePushInfo offlinePushInfo;

    /**
     * 群@用户列表
     */
    private List<String> groupAtUserList;

    /**
     * 消息的序列号
     * 群聊中的消息序列号云端生成，在群里是严格递增且唯一的。 单聊中的序列号是本地生成，不能保证严格递增且唯一。
     */
    private Long seq;

    /**
     * 描述信息
     */
    private String note;

    /**
     * 节点信息
     */
    private AbstractMessageEntity node;

    public CustomMessageEntity() {
    }

    public CustomMessageEntity(V2TIMMessage message) {
        BeanUtils.copyProperties(message, this);

        // 解析接口
        MessageNodeType nodeType = MessageNodeType.getMessageNodeTypeByV2TIMConstant(this.elemType);
        if (nodeType != MessageNodeType.None) {
            AbstractMessageNode _node = nodeType.getMessageNodeInterface();
            V2TIMElem elem = nodeType.getElemByMessage(message);
            this.note = _node.getNote(elem);
            this.node = _node.analysis(elem);
        }
    }

    public String getMsgID() {
        return msgID;
    }

    public void setMsgID(String msgID) {
        this.msgID = msgID;
    }

    public Long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Long timestamp) {
        this.timestamp = timestamp;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getFriendRemark() {
        return friendRemark;
    }

    public void setFriendRemark(String friendRemark) {
        this.friendRemark = friendRemark;
    }

    public String getFaceUrl() {
        return faceUrl;
    }

    public void setFaceUrl(String faceUrl) {
        this.faceUrl = faceUrl;
    }

    public String getNameCard() {
        return nameCard;
    }

    public void setNameCard(String nameCard) {
        this.nameCard = nameCard;
    }

    public String getGroupID() {
        return groupID;
    }

    public void setGroupID(String groupID) {
        this.groupID = groupID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getElemType() {
        return elemType;
    }

    public void setElemType(Integer elemType) {
        this.elemType = elemType;
    }

    public String getLocalCustomData() {
        return localCustomData;
    }

    public void setLocalCustomData(String localCustomData) {
        this.localCustomData = localCustomData;
    }

    public Integer getLocalCustomInt() {
        return localCustomInt;
    }

    public void setLocalCustomInt(Integer localCustomInt) {
        this.localCustomInt = localCustomInt;
    }

    public Boolean getSelf() {
        return self;
    }

    public void setSelf(Boolean self) {
        this.self = self;
    }

    public Boolean getRead() {
        return read;
    }

    public void setRead(Boolean read) {
        this.read = read;
    }

    public Boolean getPeerRead() {
        return peerRead;
    }

    public void setPeerRead(Boolean peerRead) {
        this.peerRead = peerRead;
    }

    public Integer getPriority() {
        return priority;
    }

    public void setPriority(Integer priority) {
        this.priority = priority;
    }

    public V2TIMOfflinePushInfo getOfflinePushInfo() {
        return offlinePushInfo;
    }

    public void setOfflinePushInfo(V2TIMOfflinePushInfo offlinePushInfo) {
        this.offlinePushInfo = offlinePushInfo;
    }

    public List<String> getGroupAtUserList() {
        return groupAtUserList;
    }

    public void setGroupAtUserList(List<String> groupAtUserList) {
        this.groupAtUserList = groupAtUserList;
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

    public AbstractMessageEntity getNode() {
        return node;
    }

    public void setNode(AbstractMessageEntity node) {
        this.node = node;
    }
}
