package top.huic.tencent_im_plugin.listener;

import com.tencent.imsdk.v2.V2TIMSignalingListener;

import java.util.List;

/**
 * 自定义信令监听器
 */
public class CustomSignalingListener extends V2TIMSignalingListener {
    /**
     * 收到新邀请时
     */
    @Override
    public void onReceiveNewInvitation(String inviteID, String inviter, String groupID, List<String> inviteeList, String data) {
        super.onReceiveNewInvitation(inviteID, inviter, groupID, inviteeList, data);
    }

    /**
     * 被邀请者接受邀请
     */
    @Override
    public void onInviteeAccepted(String inviteID, String invitee, String data) {
        super.onInviteeAccepted(inviteID, invitee, data);
    }

    /**
     * 被邀请者拒绝邀请
     */
    @Override
    public void onInviteeRejected(String inviteID, String invitee, String data) {
        super.onInviteeRejected(inviteID, invitee, data);
    }

    /**
     * 邀请被取消
     */
    @Override
    public void onInvitationCancelled(String inviteID, String inviter, String data) {
        super.onInvitationCancelled(inviteID, inviter, data);
    }

    /**
     * 邀请超时
     */
    @Override
    public void onInvitationTimeout(String inviteID, List<String> inviteeList) {
        super.onInvitationTimeout(inviteID, inviteeList);
    }
}
