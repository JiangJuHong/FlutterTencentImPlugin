package top.huic.tencent_im_plugin.listener;

import com.tencent.imsdk.v2.V2TIMFriendApplication;
import com.tencent.imsdk.v2.V2TIMFriendInfo;
import com.tencent.imsdk.v2.V2TIMFriendshipListener;

import java.util.List;

import top.huic.tencent_im_plugin.TencentImPlugin;
import top.huic.tencent_im_plugin.enums.ListenerTypeEnum;

/**
 * 自定义关系链监听器
 */
public class CustomFriendshipListener extends V2TIMFriendshipListener {
    /**
     * 好友申请新增通知，两种情况会收到这个回调：
     * <p>
     * 自己申请加别人好友
     * 别人申请加自己好友
     */
    @Override
    public void onFriendApplicationListAdded(List<V2TIMFriendApplication> applicationList) {
        super.onFriendApplicationListAdded(applicationList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.FriendApplicationListAdded, applicationList);
    }

    /**
     * 好友申请删除通知，四种情况会收到这个回调
     * <p>
     * 调用 deleteFriendApplication 主动删除好友申请
     * 调用 refuseFriendApplication 拒绝好友申请
     * 调用 acceptFriendApplication 同意好友申请且同意类型为 V2TIM_FRIEND_ACCEPT_AGREE 时
     * 申请加别人好友被拒绝
     */
    @Override
    public void onFriendApplicationListDeleted(List<String> userIDList) {
        super.onFriendApplicationListDeleted(userIDList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.FriendApplicationListDeleted, userIDList);
    }

    /**
     * 好友申请已读通知，如果调用 setFriendApplicationRead 设置好友申请列表已读，会收到这个回调（主要用于多端同步）
     */
    @Override
    public void onFriendApplicationListRead() {
        super.onFriendApplicationListRead();
        TencentImPlugin.invokeListener(ListenerTypeEnum.FriendApplicationListRead, null);
    }

    /**
     * 好友新增通知
     */
    @Override
    public void onFriendListAdded(List<V2TIMFriendInfo> users) {
        super.onFriendListAdded(users);
        TencentImPlugin.invokeListener(ListenerTypeEnum.FriendListAdded, users);
    }

    /**
     * 好友删除通知，，两种情况会收到这个回调：
     * <p>
     * 自己删除好友（单向和双向删除都会收到回调）
     * 好友把自己删除（双向删除会收到）
     */
    @Override
    public void onFriendListDeleted(List<String> userList) {
        super.onFriendListDeleted(userList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.FriendListDeleted, userList);
    }

    /**
     * 黑名单新增通知
     */
    @Override
    public void onBlackListAdd(List<V2TIMFriendInfo> infoList) {
        super.onBlackListAdd(infoList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.BlackListAdd, infoList);
    }

    /**
     * 黑名单删除通知
     */
    @Override
    public void onBlackListDeleted(List<String> userList) {
        super.onBlackListDeleted(userList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.BlackListDeleted, userList);
    }

    /**
     * 好友资料更新通知
     */
    @Override
    public void onFriendInfoChanged(List<V2TIMFriendInfo> infoList) {
        super.onFriendInfoChanged(infoList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.FriendInfoChanged, infoList);
    }
}
