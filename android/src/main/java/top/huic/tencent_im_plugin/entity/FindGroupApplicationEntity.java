package top.huic.tencent_im_plugin.entity;

/**
 * 查找群申请实体
 */
public class FindGroupApplicationEntity {
    /**
     * 来自用户
     */
    String fromUser;

    /**
     * 群ID
     */
    String groupID;

    public String getFromUser() {
        return fromUser;
    }

    public void setFromUser(String fromUser) {
        this.fromUser = fromUser;
    }

    public String getGroupID() {
        return groupID;
    }

    public void setGroupID(String groupID) {
        this.groupID = groupID;
    }
}
