package top.huic.tencent_im_plugin.message.entity;

import com.tencent.imsdk.TIMGroupMemberInfo;
import com.tencent.imsdk.TIMGroupTipsElem;
import com.tencent.imsdk.TIMGroupTipsElemGroupInfo;
import com.tencent.imsdk.TIMGroupTipsElemMemberInfo;
import com.tencent.imsdk.TIMGroupTipsType;
import com.tencent.imsdk.TIMUserProfile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import top.huic.tencent_im_plugin.entity.GroupMemberEntity;
import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 群提示消息实体
 *
 * @author 蒋具宏
 */
public class GroupTipsMessageEntity extends AbstractMessageEntity {
    /**
     * 被操作者群内资料
     */
    private Map<String, GroupMemberEntity> changedGroupMemberInfo;

    /**
     * 被操作帐号的个人资料
     */
    private Map<String, TIMUserProfile> changedUserInfo;

    /**
     * 群组ID
     */
    private String groupId;

    /**
     * 群名称
     */
    private String groupName;

    /**
     * 群资料变更列表信息 仅当tipsType值为TIMGroupTipsType.ModifyGroupInfo时有效
     */
    private List<TIMGroupTipsElemGroupInfo> groupInfoList;

    /**
     * 群成员变更信息列表，仅当tipsType值为TIMGroupTipsType.ModifyMemberInfo时有效
     */
    private List<TIMGroupTipsElemMemberInfo> memberInfoList;

    /**
     * 群成员数量
     */
    private Long memberNum;

    /**
     * 操作者群内信息
     */
    private TIMGroupMemberInfo opGroupMemberInfo;

    /**
     * 操作者ID
     */
    private String opUser;

    /**
     * 操作者群内资料
     */
    private TIMUserProfile opUserInfo;

    /**
     * 操作方平台资料
     */
    private String platform;

    /**
     * 群组事件通知类型
     */
    private TIMGroupTipsType tipsType;

    /**
     * 被操作的帐号列表
     */
    private List<String> userList;

    public GroupTipsMessageEntity() {
        super(MessageNodeType.GroupTips);
    }

    public GroupTipsMessageEntity(TIMGroupTipsElem elem){
        super(MessageNodeType.GroupTips);
        if (elem.getChangedGroupMemberInfo() != null) {
            Map<String, GroupMemberEntity> memberEntityMap = new HashMap<>();
            for (String key : elem.getChangedGroupMemberInfo().keySet()) {
                memberEntityMap.put(key, new GroupMemberEntity(elem.getChangedGroupMemberInfo().get(key)));
            }
            this.setChangedGroupMemberInfo(memberEntityMap);
        }

        this.setChangedUserInfo(elem.getChangedUserInfo());
        this.setGroupId(elem.getGroupId());
        this.setGroupName(elem.getGroupName());
        this.setGroupInfoList(elem.getGroupInfoList());
        this.setMemberInfoList(elem.getMemberInfoList());
        this.setMemberNum(elem.getMemberNum());
        this.setOpGroupMemberInfo(elem.getOpGroupMemberInfo());
        this.setOpUser(elem.getOpUser());
        this.setOpUserInfo(elem.getOpUserInfo());
        this.setPlatform(elem.getPlatform());
        this.setTipsType(elem.getTipsType());
        this.setUserList(elem.getUserList());
    }

    public Map<String, GroupMemberEntity> getChangedGroupMemberInfo() {
        return changedGroupMemberInfo;
    }

    public void setChangedGroupMemberInfo(Map<String, GroupMemberEntity> changedGroupMemberInfo) {
        this.changedGroupMemberInfo = changedGroupMemberInfo;
    }

    public Map<String, TIMUserProfile> getChangedUserInfo() {
        return changedUserInfo;
    }

    public void setChangedUserInfo(Map<String, TIMUserProfile> changedUserInfo) {
        this.changedUserInfo = changedUserInfo;
    }

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public List<TIMGroupTipsElemGroupInfo> getGroupInfoList() {
        return groupInfoList;
    }

    public void setGroupInfoList(List<TIMGroupTipsElemGroupInfo> groupInfoList) {
        this.groupInfoList = groupInfoList;
    }

    public List<TIMGroupTipsElemMemberInfo> getMemberInfoList() {
        return memberInfoList;
    }

    public void setMemberInfoList(List<TIMGroupTipsElemMemberInfo> memberInfoList) {
        this.memberInfoList = memberInfoList;
    }

    public Long getMemberNum() {
        return memberNum;
    }

    public void setMemberNum(Long memberNum) {
        this.memberNum = memberNum;
    }

    public TIMGroupMemberInfo getOpGroupMemberInfo() {
        return opGroupMemberInfo;
    }

    public void setOpGroupMemberInfo(TIMGroupMemberInfo opGroupMemberInfo) {
        this.opGroupMemberInfo = opGroupMemberInfo;
    }

    public String getOpUser() {
        return opUser;
    }

    public void setOpUser(String opUser) {
        this.opUser = opUser;
    }

    public TIMUserProfile getOpUserInfo() {
        return opUserInfo;
    }

    public void setOpUserInfo(TIMUserProfile opUserInfo) {
        this.opUserInfo = opUserInfo;
    }

    public String getPlatform() {
        return platform;
    }

    public void setPlatform(String platform) {
        this.platform = platform;
    }

    public TIMGroupTipsType getTipsType() {
        return tipsType;
    }

    public void setTipsType(TIMGroupTipsType tipsType) {
        this.tipsType = tipsType;
    }

    public List<String> getUserList() {
        return userList;
    }

    public void setUserList(List<String> userList) {
        this.userList = userList;
    }
}