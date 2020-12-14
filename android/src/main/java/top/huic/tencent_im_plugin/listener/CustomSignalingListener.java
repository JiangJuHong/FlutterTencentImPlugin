package top.huic.tencent_im_plugin.listener;

import com.tencent.imsdk.v2.V2TIMSignalingListener;

import java.util.HashMap;
import java.util.List;

import top.huic.tencent_im_plugin.TencentImPlugin;
import top.huic.tencent_im_plugin.enums.ListenerTypeEnum;

/**
 * 自定义信令监听器
 */
public class CustomSignalingListener extends V2TIMSignalingListener {
    /**
     * 收到新邀请时
     */
    @Override
    public void onReceiveNewInvitation(final String inviteID, final String inviter, final String groupID, final List<String> inviteeList, final String data) {
        super.onReceiveNewInvitation(inviteID, inviter, groupID, inviteeList, data);
        TencentImPlugin.invokeListener(ListenerTypeEnum.ReceiveNewInvitation, new HashMap<String, Object>() {
            {
                put("inviteID", inviteID);
                put("inviter", inviter);
                put("groupID", groupID);
                put("inviteeList", inviteeList);
                put("data", data);
            }
        });
    }

    /**
     * 被邀请者接受邀请
     */
    @Override
    public void onInviteeAccepted(final String inviteID, final String invitee, final String data) {
        super.onInviteeAccepted(inviteID, invitee, data);
        TencentImPlugin.invokeListener(ListenerTypeEnum.InviteeAccepted, new HashMap<String, Object>() {
            {
                put("inviteID", inviteID);
                put("invitee", invitee);
                put("data", data);
            }
        });
    }

    /**
     * 被邀请者拒绝邀请
     */
    @Override
    public void onInviteeRejected(final String inviteID, final String invitee, final String data) {
        super.onInviteeRejected(inviteID, invitee, data);
        TencentImPlugin.invokeListener(ListenerTypeEnum.InviteeRejected, new HashMap<String, Object>() {
            {
                put("inviteID", inviteID);
                put("invitee", invitee);
                put("data", data);
            }
        });
    }

    /**
     * 邀请被取消
     */
    @Override
    public void onInvitationCancelled(final String inviteID, final String inviter, final String data) {
        super.onInvitationCancelled(inviteID, inviter, data);
        TencentImPlugin.invokeListener(ListenerTypeEnum.InvitationCancelled, new HashMap<String, Object>() {
            {
                put("inviteID", inviteID);
                put("inviter", inviter);
                put("data", data);
            }
        });
    }

    /**
     * 邀请超时
     */
    @Override
    public void onInvitationTimeout(final String inviteID, final List<String> inviteeList) {
        super.onInvitationTimeout(inviteID, inviteeList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.InvitationTimeout, new HashMap<String, Object>() {
            {
                put("inviteID", inviteID);
                put("inviteeList", inviteeList);
            }
        });
    }
}
