package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.v2.V2TIMFriendAddApplication;

/**
 * 自定义好友添加申请实体
 */
public class CustomFriendAddApplication extends V2TIMFriendAddApplication {
    public CustomFriendAddApplication() {
        super(null);
    }

    public CustomFriendAddApplication(String userID) {
        super(userID);
    }
}
