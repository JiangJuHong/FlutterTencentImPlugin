package top.huic.tencent_im_plugin.listener;

import com.tencent.imsdk.v2.V2TIMConversation;
import com.tencent.imsdk.v2.V2TIMConversationListener;

import java.util.List;

import top.huic.tencent_im_plugin.TencentImPlugin;
import top.huic.tencent_im_plugin.enums.ListenerTypeEnum;

/**
 * 自定义会话监听
 */
public class CustomConversationListener extends V2TIMConversationListener {
    /**
     * 同步服务开始
     */
    @Override
    public void onSyncServerStart() {
        super.onSyncServerStart();
        TencentImPlugin.invokeListener(ListenerTypeEnum.SyncServerStart, null);
    }

    /**
     * 同步服务完成
     */
    @Override
    public void onSyncServerFinish() {
        super.onSyncServerFinish();
        TencentImPlugin.invokeListener(ListenerTypeEnum.SyncServerFinish, null);
    }

    /**
     * 同步服务失败
     */
    @Override
    public void onSyncServerFailed() {
        super.onSyncServerFailed();
        TencentImPlugin.invokeListener(ListenerTypeEnum.SyncServerFailed, null);
    }

    /**
     * 新会话
     */
    @Override
    public void onNewConversation(List<V2TIMConversation> conversationList) {
        super.onNewConversation(conversationList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.NewConversation, conversationList);
    }

    /**
     * 会话刷新
     */
    @Override
    public void onConversationChanged(List<V2TIMConversation> conversationList) {
        super.onConversationChanged(conversationList);
        TencentImPlugin.invokeListener(ListenerTypeEnum.ConversationChanged, conversationList);
    }
}
