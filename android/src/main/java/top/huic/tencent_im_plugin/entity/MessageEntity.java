package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.TIMElem;
import com.tencent.imsdk.TIMGroupMemberInfo;
import com.tencent.imsdk.TIMUserProfile;

import java.util.List;

/**
 * 消息实体
 *
 * @author 蒋具宏
 */
public class MessageEntity {
    /**
     * 消息ID
     */
    private String id;

    /**
     * 唯一ID
     */
    private Long uniqueId;

    /**
     * 随机码
     */
    private Long rand;

    /**
     * 序列号
     */
    private Long seq;

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
    private List<TIMElem> elemList;

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

    public List<TIMElem> getElemList() {
        return elemList;
    }

    public void setElemList(List<TIMElem> elemList) {
        this.elemList = elemList;
    }
}
