package top.huic.tencent_im_plugin.message.entity;

import com.tencent.imsdk.TIMGroupSystemElem;
import com.tencent.imsdk.TIMGroupSystemElemType;
import com.tencent.imsdk.TIMUserProfile;

import top.huic.tencent_im_plugin.entity.GroupMemberEntity;
import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 群系统消息节点
 */
public class GroupSystemEntity extends AbstractMessageEntity {

    /**
     * 操作方平台信息
     * 取值： iOS Android Windows Mac Web RESTAPI Unknown
     */
    private String platform;

    /**
     * 消息子类型
     */
    private long subtype;

    /**
     * 群ID
     */
    private String groupId;

    /**
     * 自定义通知
     */
    private String userData;

    /**
     * 操作者个人资料
     */
    private TIMUserProfile opUserInfo;

    /**
     * 操作者群内资料
     */
    private GroupMemberEntity opGroupMemberInfo;

    public GroupSystemEntity(MessageNodeType nodeType) {
        super(MessageNodeType.GroupSystem);
    }

    public GroupSystemEntity(TIMGroupSystemElem elem) {
        super(MessageNodeType.GroupSystem);
        this.platform = elem.getPlatform();
        this.subtype = elem.getSubtype().getValue();
        this.groupId = elem.getGroupId();
        this.opUserInfo = elem.getOpUserInfo();
        this.userData = elem.getUserData() != null ? new String(elem.getUserData()) : null;
        this.opGroupMemberInfo = new GroupMemberEntity(elem.getOpGroupMemberInfo());
    }

    public String getPlatform() {
        return platform;
    }

    public void setPlatform(String platform) {
        this.platform = platform;
    }

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public String getUserData() {
        return userData;
    }

    public void setUserData(String userData) {
        this.userData = userData;
    }

    public TIMUserProfile getOpUserInfo() {
        return opUserInfo;
    }

    public void setOpUserInfo(TIMUserProfile opUserInfo) {
        this.opUserInfo = opUserInfo;
    }

    public GroupMemberEntity getOpGroupMemberInfo() {
        return opGroupMemberInfo;
    }

    public void setOpGroupMemberInfo(GroupMemberEntity opGroupMemberInfo) {
        this.opGroupMemberInfo = opGroupMemberInfo;
    }

    public long getSubtype() {
        return subtype;
    }

    public void setSubtype(long subtype) {
        this.subtype = subtype;
    }
}
