package top.huic.tencent_im_plugin.entity;

/**
 * 查找好友申请实体
 */
public class FindFriendApplicationEntity {
    /**
     * 用户ID
     */
    String userID;

    /**
     * 类型
     */
    int type;

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }
}
