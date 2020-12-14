package top.huic.tencent_im_plugin.listener;

import com.tencent.imsdk.v2.V2TIMGroupChangeInfo;
import com.tencent.imsdk.v2.V2TIMGroupListener;
import com.tencent.imsdk.v2.V2TIMGroupMemberChangeInfo;
import com.tencent.imsdk.v2.V2TIMGroupMemberInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import top.huic.tencent_im_plugin.TencentImPlugin;
import top.huic.tencent_im_plugin.enums.ListenerTypeEnum;

/**
 * 自定义群监听
 */
public class CustomGroupListener extends V2TIMGroupListener {
    /**
     * 有用户加入群（全员能够收到）
     */
    @Override
    public void onMemberEnter(final String groupID, final List<V2TIMGroupMemberInfo> memberList) {
        super.onMemberEnter(groupID, memberList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.MemberEnter, new HashMap<String, Object>() {
            {
                put("groupID", groupID);
                put("memberList", memberList);
            }
        });
    }

    /**
     * 有用户离开群（全员能够收到）
     */
    @Override
    public void onMemberLeave(final String groupID, final V2TIMGroupMemberInfo member) {
        super.onMemberLeave(groupID, member);
        TencentImPlugin.invokeListener(ListenerTypeEnum.MemberLeave, new HashMap<String, Object>() {
            {
                put("groupID", groupID);
                put("member", member);
            }
        });
    }

    /**
     * 某些人被拉入某群（全员能够收到）
     */
    @Override
    public void onMemberInvited(final String groupID, final V2TIMGroupMemberInfo opUser, final List<V2TIMGroupMemberInfo> memberList) {
        super.onMemberInvited(groupID, opUser, memberList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.MemberInvited, new HashMap<String, Object>() {
            {
                put("groupID", groupID);
                put("opUser", opUser);
                put("memberList", memberList);
            }
        });
    }

    /**
     * 某些人被踢出某群（全员能够收到）
     */
    @Override
    public void onMemberKicked(final String groupID, final V2TIMGroupMemberInfo opUser, final List<V2TIMGroupMemberInfo> memberList) {
        super.onMemberKicked(groupID, opUser, memberList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.MemberKicked, new HashMap<String, Object>() {
            {
                put("groupID", groupID);
                put("opUser", opUser);
                put("memberList", memberList);
            }
        });
    }

    /**
     * 群成员信息被修改（全员能收到）
     */
    @Override
    public void onMemberInfoChanged(final String groupID, final List<V2TIMGroupMemberChangeInfo> v2TIMGroupMemberChangeInfoList) {
        super.onMemberInfoChanged(groupID, v2TIMGroupMemberChangeInfoList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.MemberInfoChanged, new HashMap<String, Object>() {
            {
                put("groupID", groupID);
                put("changInfo", v2TIMGroupMemberChangeInfoList);
            }
        });
    }

    /**
     * 创建群（主要用于多端同步）
     */
    @Override
    public void onGroupCreated(String groupID) {
        super.onGroupCreated(groupID);
        TencentImPlugin.invokeListener(ListenerTypeEnum.GroupCreated, groupID);
    }

    /**
     * 群被解散了（全员能收到）
     */
    @Override
    public void onGroupDismissed(final String groupID, final V2TIMGroupMemberInfo opUser) {
        super.onGroupDismissed(groupID, opUser);
        TencentImPlugin.invokeListener(ListenerTypeEnum.GroupDismissed, new HashMap<String, Object>() {
            {
                put("groupID", groupID);
                put("opUser", opUser);
            }
        });
    }

    /**
     * 群被回收（全员能收到）
     */
    @Override
    public void onGroupRecycled(final String groupID, final V2TIMGroupMemberInfo opUser) {
        super.onGroupRecycled(groupID, opUser);
        TencentImPlugin.invokeListener(ListenerTypeEnum.GroupRecycled, new HashMap<String, Object>() {
            {
                put("groupID", groupID);
                put("opUser", opUser);
            }
        });
    }

    /**
     * 群信息被修改（全员能收到）
     */
    @Override
    public void onGroupInfoChanged(final String groupID, final List<V2TIMGroupChangeInfo> changeInfos) {
        super.onGroupInfoChanged(groupID, changeInfos);
        TencentImPlugin.invokeListener(ListenerTypeEnum.GroupInfoChanged, new HashMap<String, Object>() {
            {
                put("groupID", groupID);
                put("changInfo", changeInfos);
            }
        });
    }

    /**
     * 有新的加群请求（只有群主或管理员会收到）
     */
    @Override
    public void onReceiveJoinApplication(final String groupID, final V2TIMGroupMemberInfo member, final String opReason) {
        super.onReceiveJoinApplication(groupID, member, opReason);
        TencentImPlugin.invokeListener(ListenerTypeEnum.ReceiveJoinApplication, new HashMap<String, Object>() {
            {
                put("groupID", groupID);
                put("member", member);
                put("opReason", opReason);
            }
        });
    }

    /**
     * 加群请求已经被群主或管理员处理了（只有申请人能够收到）
     */
    @Override
    public void onApplicationProcessed(final String groupID, final V2TIMGroupMemberInfo opUser, final boolean isAgreeJoin, final String opReason) {
        super.onApplicationProcessed(groupID, opUser, isAgreeJoin, opReason);
        TencentImPlugin.invokeListener(ListenerTypeEnum.ApplicationProcessed, new HashMap<String, Object>() {
            {
                put("groupID", groupID);
                put("opUser", opUser);
                put("isAgreeJoin", isAgreeJoin);
                put("opReason", opReason);
            }
        });
    }

    /**
     * 指定管理员身份
     */
    @Override
    public void onGrantAdministrator(final String groupID, final V2TIMGroupMemberInfo opUser, final List<V2TIMGroupMemberInfo> memberList) {
        super.onGrantAdministrator(groupID, opUser, memberList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.GrantAdministrator, new HashMap<String, Object>() {
            {
                put("groupID", groupID);
                put("opUser", opUser);
                put("memberList", memberList);
            }
        });
    }

    /**
     * 取消管理员身份
     */
    @Override
    public void onRevokeAdministrator(final String groupID, final V2TIMGroupMemberInfo opUser, final List<V2TIMGroupMemberInfo> memberList) {
        super.onRevokeAdministrator(groupID, opUser, memberList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.RevokeAdministrator, new HashMap<String, Object>() {
            {
                put("groupID", groupID);
                put("opUser", opUser);
                put("memberList", memberList);
            }
        });
    }

    /**
     * 主动退出群组（主要用于多端同步，直播群（AVChatRoom）不支持）
     */
    @Override
    public void onQuitFromGroup(String groupID) {
        super.onQuitFromGroup(groupID);
        TencentImPlugin.invokeListener(ListenerTypeEnum.QuitFromGroup, groupID);
    }

    /**
     * 收到 RESTAPI 下发的自定义系统消息
     */
    @Override
    public void onReceiveRESTCustomData(final String groupID, final byte[] customData) {
        super.onReceiveRESTCustomData(groupID, customData);
        TencentImPlugin.invokeListener(ListenerTypeEnum.ReceiveRESTCustomData, new HashMap<String, Object>() {
            {
                put("groupID", groupID);
                put("customData", new String(customData));
            }
        });
    }

    /**
     * 收到群属性更新的回调
     */
    @Override
    public void onGroupAttributeChanged(final String groupID, final Map<String, String> groupAttributeMap) {
        super.onGroupAttributeChanged(groupID, groupAttributeMap);
        TencentImPlugin.invokeListener(ListenerTypeEnum.GroupAttributeChanged, new HashMap<String, Object>() {
            {
                put("groupID", groupID);
                put("attributes", groupAttributeMap);
            }
        });
    }
}
