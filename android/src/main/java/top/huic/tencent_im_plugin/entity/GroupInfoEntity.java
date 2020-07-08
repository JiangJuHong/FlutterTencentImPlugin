package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.TIMGroupAddOpt;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.ext.group.TIMGroupDetailInfo;
import com.tencent.imsdk.ext.group.TIMGroupDetailInfoResult;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class GroupInfoEntity implements Serializable {
    private long unreadMessageNum;
    private static final String tag = "GroupInfoEntity";
    private String groupId = "";
    private String groupName = "";
    private String groupOwner = "";
    private String groupNotice = "";
    private String groupIntroduction = "";
    private String groupFaceUrl = "";
    private String groupType = "";
    private long createTime;
    private long lastInfoTime;
    private long lastMsgTime;
    private long memberNum;
    private long maxMemberNum;
    private long onlineMemberNum;
    private TIMGroupAddOpt addOption;
    private int intAddOption;
    private boolean isSilenceAll = false;
    private TIMMessage lastMsg = null;
    private Map<String, byte[]> custom = new HashMap();
    public static String getTag() {
        return tag;
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

    public String getGroupOwner() {
        return groupOwner;
    }

    public void setGroupOwner(String groupOwner) {
        this.groupOwner = groupOwner;
    }

    public String getGroupNotice() {
        return groupNotice;
    }

    public void setGroupNotice(String groupNotice) {
        this.groupNotice = groupNotice;
    }

    public String getGroupIntroduction() {
        return groupIntroduction;
    }

    public void setGroupIntroduction(String groupIntroduction) {
        this.groupIntroduction = groupIntroduction;
    }

    public String getGroupFaceUrl() {
        return groupFaceUrl;
    }

    public void setGroupFaceUrl(String groupFaceUrl) {
        this.groupFaceUrl = groupFaceUrl;
    }

    public String getGroupType() {
        return groupType;
    }

    public void setGroupType(String groupType) {
        this.groupType = groupType;
    }

    public long getCreateTime() {
        return createTime;
    }

    public void setCreateTime(long createTime) {
        this.createTime = createTime;
    }

    public long getLastInfoTime() {
        return lastInfoTime;
    }

    public void setLastInfoTime(long lastInfoTime) {
        this.lastInfoTime = lastInfoTime;
    }

    public long getLastMsgTime() {
        return lastMsgTime;
    }

    public void setLastMsgTime(long lastMsgTime) {
        this.lastMsgTime = lastMsgTime;
    }

    public long getMemberNum() {
        return memberNum;
    }

    public void setMemberNum(long memberNum) {
        this.memberNum = memberNum;
    }

    public long getMaxMemberNum() {
        return maxMemberNum;
    }

    public void setMaxMemberNum(long maxMemberNum) {
        this.maxMemberNum = maxMemberNum;
    }

    public long getOnlineMemberNum() {
        return onlineMemberNum;
    }

    public void setOnlineMemberNum(long onlineMemberNum) {
        this.onlineMemberNum = onlineMemberNum;
    }

    public TIMGroupAddOpt getAddOption() {
        return addOption;
    }

    public void setAddOption(TIMGroupAddOpt addOption) {
        this.addOption = addOption;
    }

    public int getIntAddOption() {
        return intAddOption;
    }

    public void setIntAddOption(int intAddOption) {
        this.intAddOption = intAddOption;
    }

    public boolean isSilenceAll() {
        return isSilenceAll;
    }

    public void setSilenceAll(boolean silenceAll) {
        isSilenceAll = silenceAll;
    }

    public TIMMessage getLastMsg() {
        return lastMsg;
    }

    public void setLastMsg(TIMMessage lastMsg) {
        this.lastMsg = lastMsg;
    }

    public Map<String, byte[]> getCustom() {
        return custom;
    }

    public void setCustom(Map<String, byte[]> custom) {
        this.custom = custom;
    }
    public long getUnreadMessageNum() {
        return unreadMessageNum;
    }

    public void setUnreadMessageNum(long unreadMessageNum) {
        this.unreadMessageNum = unreadMessageNum;
    }
}
