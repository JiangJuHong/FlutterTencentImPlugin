package top.huic.tencent_im_plugin.message.entity;

import com.tencent.imsdk.v2.V2TIMGroupChangeInfo;
import com.tencent.imsdk.v2.V2TIMGroupMemberChangeInfo;
import com.tencent.imsdk.v2.V2TIMGroupMemberInfo;
import com.tencent.imsdk.v2.V2TIMGroupTipsElem;

import java.util.List;

import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 群提示消息实体
 *
 * @author 蒋具宏
 */
public class GroupTipsMessageEntity extends AbstractMessageEntity {

    /**
     * 群ID
     */
    private String groupID;

    /**
     * 群事件通知类型
     */
    private int type;

    /**
     * 操作用户
     */
    private V2TIMGroupMemberInfo opMember;

    /**
     * 被操作人列表
     */
    private List<V2TIMGroupMemberInfo> memberList;

    /**
     * 群资料变更信息列表，仅当tipsType值为V2TIMGroupTipsElem#V2TIM_GROUP_TIPS_TYPE_GROUP_INFO_CHANGE时有效
     */
    private List<V2TIMGroupChangeInfo> groupChangeInfoList	;

    /**
     * 获取群成员变更信息列表，仅当tipsType值为V2TIMGroupTipsElem#V2TIM_GROUP_TIPS_TYPE_MEMBER_INFO_CHANGE时有效
     */
    private List<V2TIMGroupMemberChangeInfo> memberChangeInfoList;

    /**
     * 当前群成员数，仅当tipsType值为V2TIMGroupTipsElem#V2TIM_GROUP_TIPS_TYPE_JOIN, V2TIMGroupTipsElem#V2TIM_GROUP_TIPS_TYPE_QUIT, V2TIMGroupTipsElem#V2TIM_GROUP_TIPS_TYPE_KICKED的时候有效
     */
    private int memberCount;

    public GroupTipsMessageEntity() {
        super(MessageNodeType.GroupTips);
    }

    public GroupTipsMessageEntity(V2TIMGroupTipsElem elem){
        super(MessageNodeType.GroupTips);
        this.groupID = elem.getGroupID();
        this.type = elem.getType();
        this.opMember = elem.getOpMember();
        this.memberList = elem.getMemberList();
        this.groupChangeInfoList = elem.getGroupChangeInfoList();
        this.memberChangeInfoList = elem.getMemberChangeInfoList();
        this.memberCount = elem.getMemberCount();
    }

    public String getGroupID() {
        return groupID;
    }

    public void setGroupID(String groupID) {
        this.groupID = groupID;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public V2TIMGroupMemberInfo getOpMember() {
        return opMember;
    }

    public void setOpMember(V2TIMGroupMemberInfo opMember) {
        this.opMember = opMember;
    }

    public List<V2TIMGroupMemberInfo> getMemberList() {
        return memberList;
    }

    public void setMemberList(List<V2TIMGroupMemberInfo> memberList) {
        this.memberList = memberList;
    }

    public List<V2TIMGroupChangeInfo> getGroupChangeInfoList() {
        return groupChangeInfoList;
    }

    public void setGroupChangeInfoList(List<V2TIMGroupChangeInfo> groupChangeInfoList) {
        this.groupChangeInfoList = groupChangeInfoList;
    }

    public List<V2TIMGroupMemberChangeInfo> getMemberChangeInfoList() {
        return memberChangeInfoList;
    }

    public void setMemberChangeInfoList(List<V2TIMGroupMemberChangeInfo> memberChangeInfoList) {
        this.memberChangeInfoList = memberChangeInfoList;
    }

    public int getMemberCount() {
        return memberCount;
    }

    public void setMemberCount(int memberCount) {
        this.memberCount = memberCount;
    }
}