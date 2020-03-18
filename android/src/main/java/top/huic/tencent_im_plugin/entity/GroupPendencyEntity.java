package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.TIMUserProfile;
import com.tencent.imsdk.ext.group.TIMGroupDetailInfo;
import com.tencent.imsdk.ext.group.TIMGroupPendencyGetType;
import com.tencent.imsdk.ext.group.TIMGroupPendencyHandledStatus;
import com.tencent.imsdk.ext.group.TIMGroupPendencyItem;
import com.tencent.imsdk.ext.group.TIMGroupPendencyOperationType;

import java.io.Serializable;

/**
 * 群未决实体
 *
 * @author 蒋具宏
 */
public class GroupPendencyEntity implements Serializable {
    /**
     * 来自(请求人/邀请人)
     */
    private String fromUser;
    /**
     * 群ID
     */
    private String groupId;
    /**
     * 处理者添加的附加信息
     */
    private String handledMsg;
    /**
     * 处理状态
     */
    private TIMGroupPendencyHandledStatus handledStatus;

    /**
     * 申请人ID
     */
    private String identifier;

    /**
     * 增加时间
     */
    private long addTime;

    /**
     * 操作类型
     */
    private TIMGroupPendencyOperationType operationType;

    /**
     * 请求类型
     */
    private TIMGroupPendencyGetType pendencyType;

    /**
     * 请求附加信息
     */
    private String requestMsg;

    /**
     * 处理者ID
     */
    private String toUser;

    /**
     * 申请人信息
     */
    private TIMUserProfile applyUserInfo;

    /**
     * 处理人信息
     */
    private TIMUserProfile handlerUserInfo;

    /**
     * 群信息
     */
    private TIMGroupDetailInfo groupInfo;

    public GroupPendencyEntity(TIMGroupPendencyItem data) {
        this.fromUser = data.getFromUser();
        this.groupId = data.getGroupId();
        this.handledMsg = data.getHandledMsg();
        this.handledStatus = data.getHandledStatus();
        this.identifier = data.getIdentifer();
        this.addTime = data.getAddTime();
        this.operationType = data.getOperationType();
        this.pendencyType = data.getPendencyType();
        this.requestMsg = data.getRequestMsg();
        this.toUser = data.getToUser();
    }

    public String getFromUser() {
        return fromUser;
    }

    public void setFromUser(String fromUser) {
        this.fromUser = fromUser;
    }

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public String getHandledMsg() {
        return handledMsg;
    }

    public void setHandledMsg(String handledMsg) {
        this.handledMsg = handledMsg;
    }

    public TIMGroupPendencyHandledStatus getHandledStatus() {
        return handledStatus;
    }

    public void setHandledStatus(TIMGroupPendencyHandledStatus handledStatus) {
        this.handledStatus = handledStatus;
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

    public TIMGroupPendencyOperationType getOperationType() {
        return operationType;
    }

    public void setOperationType(TIMGroupPendencyOperationType operationType) {
        this.operationType = operationType;
    }

    public TIMGroupPendencyGetType getPendencyType() {
        return pendencyType;
    }

    public void setPendencyType(TIMGroupPendencyGetType pendencyType) {
        this.pendencyType = pendencyType;
    }

    public String getRequestMsg() {
        return requestMsg;
    }

    public void setRequestMsg(String requestMsg) {
        this.requestMsg = requestMsg;
    }

    public String getToUser() {
        return toUser;
    }

    public void setToUser(String toUser) {
        this.toUser = toUser;
    }

    public TIMUserProfile getApplyUserInfo() {
        return applyUserInfo;
    }

    public void setApplyUserInfo(TIMUserProfile applyUserInfo) {
        this.applyUserInfo = applyUserInfo;
    }

    public TIMUserProfile getHandlerUserInfo() {
        return handlerUserInfo;
    }

    public void setHandlerUserInfo(TIMUserProfile handlerUserInfo) {
        this.handlerUserInfo = handlerUserInfo;
    }

    public TIMGroupDetailInfo getGroupInfo() {
        return groupInfo;
    }

    public void setGroupInfo(TIMGroupDetailInfo groupInfo) {
        this.groupInfo = groupInfo;
    }
}