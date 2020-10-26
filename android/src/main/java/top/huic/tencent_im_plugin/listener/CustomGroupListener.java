package top.huic.tencent_im_plugin.listener;

import com.tencent.imsdk.v2.V2TIMGroupChangeInfo;
import com.tencent.imsdk.v2.V2TIMGroupListener;
import com.tencent.imsdk.v2.V2TIMGroupMemberChangeInfo;
import com.tencent.imsdk.v2.V2TIMGroupMemberInfo;

import java.util.List;
import java.util.Map;

/**
 * 自定义群监听
 */
public class CustomGroupListener extends V2TIMGroupListener {
    /**
     * 有用户加入群（全员能够收到）
     */
    @Override
    public void onMemberEnter(String groupID, List<V2TIMGroupMemberInfo> memberList) {
        super.onMemberEnter(groupID, memberList);
    }

    /**
     * 有用户离开群（全员能够收到）
     */
    @Override
    public void onMemberLeave(String groupID, V2TIMGroupMemberInfo member) {
        super.onMemberLeave(groupID, member);
    }

    /**
     * 某些人被拉入某群（全员能够收到）
     */
    @Override
    public void onMemberInvited(String groupID, V2TIMGroupMemberInfo opUser, List<V2TIMGroupMemberInfo> memberList) {
        super.onMemberInvited(groupID, opUser, memberList);
    }

    /**
     * 某些人被踢出某群（全员能够收到）
     */
    @Override
    public void onMemberKicked(String groupID, V2TIMGroupMemberInfo opUser, List<V2TIMGroupMemberInfo> memberList) {
        super.onMemberKicked(groupID, opUser, memberList);
    }

    /**
     * 群成员信息被修改（全员能收到）
     */
    @Override
    public void onMemberInfoChanged(String groupID, List<V2TIMGroupMemberChangeInfo> v2TIMGroupMemberChangeInfoList) {
        super.onMemberInfoChanged(groupID, v2TIMGroupMemberChangeInfoList);
    }

    /**
     * 创建群（主要用于多端同步）
     */
    @Override
    public void onGroupCreated(String groupID) {
        super.onGroupCreated(groupID);
    }

    /**
     * 群被解散了（全员能收到）
     */
    @Override
    public void onGroupDismissed(String groupID, V2TIMGroupMemberInfo opUser) {
        super.onGroupDismissed(groupID, opUser);
    }

    /**
     * 群被回收（全员能收到）
     */
    @Override
    public void onGroupRecycled(String groupID, V2TIMGroupMemberInfo opUser) {
        super.onGroupRecycled(groupID, opUser);
    }

    /**
     * 群信息被修改（全员能收到）
     */
    @Override
    public void onGroupInfoChanged(String groupID, List<V2TIMGroupChangeInfo> changeInfos) {
        super.onGroupInfoChanged(groupID, changeInfos);
    }

    /**
     * 有新的加群请求（只有群主或管理员会收到）
     */
    @Override
    public void onReceiveJoinApplication(String groupID, V2TIMGroupMemberInfo member, String opReason) {
        super.onReceiveJoinApplication(groupID, member, opReason);
    }

    /**
     * 加群请求已经被群主或管理员处理了（只有申请人能够收到）
     */
    @Override
    public void onApplicationProcessed(String groupID, V2TIMGroupMemberInfo opUser, boolean isAgreeJoin, String opReason) {
        super.onApplicationProcessed(groupID, opUser, isAgreeJoin, opReason);
    }

    /**
     * 指定管理员身份
     */
    @Override
    public void onGrantAdministrator(String groupID, V2TIMGroupMemberInfo opUser, List<V2TIMGroupMemberInfo> memberList) {
        super.onGrantAdministrator(groupID, opUser, memberList);
    }

    /**
     * 取消管理员身份
     */
    @Override
    public void onRevokeAdministrator(String groupID, V2TIMGroupMemberInfo opUser, List<V2TIMGroupMemberInfo> memberList) {
        super.onRevokeAdministrator(groupID, opUser, memberList);
    }

    /**
     * 主动退出群组（主要用于多端同步，直播群（AVChatRoom）不支持）
     */
    @Override
    public void onQuitFromGroup(String groupID) {
        super.onQuitFromGroup(groupID);
    }

    /**
     * 收到 RESTAPI 下发的自定义系统消息
     */
    @Override
    public void onReceiveRESTCustomData(String groupID, byte[] customData) {
        super.onReceiveRESTCustomData(groupID, customData);
    }

    /**
     * 收到群属性更新的回调
     */
    @Override
    public void onGroupAttributeChanged(String groupID, Map<String, String> groupAttributeMap) {
        super.onGroupAttributeChanged(groupID, groupAttributeMap);
    }
}
