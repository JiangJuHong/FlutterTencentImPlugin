package top.huic.tencent_im_plugin.listener;

import android.util.Log;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMGroupEventListener;
import com.tencent.imsdk.TIMGroupTipsElem;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMMessageListener;
import com.tencent.imsdk.TIMRefreshListener;
import com.tencent.imsdk.TIMUploadProgressListener;
import com.tencent.imsdk.ext.message.TIMMessageLocator;
import com.tencent.imsdk.ext.message.TIMMessageReceipt;
import com.tencent.imsdk.ext.message.TIMMessageReceiptListener;
import com.tencent.imsdk.ext.message.TIMMessageRevokedListener;
import com.tencent.imsdk.v2.V2TIMSDKListener;
import com.tencent.imsdk.v2.V2TIMUserFullInfo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;
import top.huic.tencent_im_plugin.TencentImPlugin;
import top.huic.tencent_im_plugin.ValueCallBack;
import top.huic.tencent_im_plugin.entity.MessageEntity;
import top.huic.tencent_im_plugin.entity.SessionEntity;
import top.huic.tencent_im_plugin.enums.ListenerTypeEnum;
import top.huic.tencent_im_plugin.message.entity.GroupTipsMessageEntity;
import top.huic.tencent_im_plugin.util.JsonUtil;
import top.huic.tencent_im_plugin.util.TencentImUtils;

/**
 * 腾讯云IM监听器
 *
 * @author 蒋具宏
 */
public class TencentImListener extends V2TIMSDKListener implements
        TIMGroupEventListener,
        TIMRefreshListener, TIMMessageRevokedListener,
        TIMMessageListener, TIMMessageReceiptListener,
        TIMUploadProgressListener {

    /**
     * 监听器回调的方法名
     */
    private final static String LISTENER_FUNC_NAME = "onListener";

    /**
     * 与Flutter的通信管道
     */
    private static MethodChannel channel;

    public TencentImListener(MethodChannel channel) {
        TencentImListener.channel = channel;
    }

    /**
     * 调用监听器
     *
     * @param type   类型
     * @param params 参数
     */
    public static void invokeListener(ListenerTypeEnum type, Object params) {
        Map<String, Object> resultParams = new HashMap<>(2, 1);
        resultParams.put("type", type);
        resultParams.put("params", params == null ? null : JsonUtil.toJSONString(params));
        channel.invokeMethod(LISTENER_FUNC_NAME, JsonUtil.toJSONString(resultParams));
    }

    /**
     * 正在连接到腾讯云服务器
     */
    @Override
    public void onConnecting() {
        super.onConnecting();
    }

    /**
     * 网络连接成功
     */
    @Override
    public void onConnectSuccess() {
        super.onConnectSuccess();
    }

    /**
     * 网络连接失败
     */
    @Override
    public void onConnectFailed(int code, String error) {
        super.onConnectFailed(code, error);
    }

    /**
     * 踢下线通知
     */
    @Override
    public void onKickedOffline() {
        super.onKickedOffline();
    }

    /**
     * 当前用户的资料发生了更新
     */
    @Override
    public void onSelfInfoUpdated(V2TIMUserFullInfo info) {
        super.onSelfInfoUpdated(info);
    }

    /**
     * 用户登录的 userSig 过期（用户需要重新获取 userSig 后登录）
     */
    @Override
    public void onUserSigExpired() {
        super.onUserSigExpired();
    }




    /**
     * 群消息事件
     */
    @Override
    public void onGroupTipsEvent(TIMGroupTipsElem timGroupTipsElem) {
        invokeListener(ListenerTypeEnum.GroupTips, new GroupTipsMessageEntity(timGroupTipsElem));
    }

    /**
     * 会话刷新
     */
    @Override
    public void onRefresh() {
        invokeListener(ListenerTypeEnum.Refresh, null);
    }

    /**
     * 刷新部分会话
     */
    @Override
    public void onRefreshConversation(List<TIMConversation> list) {
        // 获取资料后调用回调
        TencentImUtils.getConversationInfo(new ValueCallBack<List<SessionEntity>>(null) {
            @Override
            public void onSuccess(List<SessionEntity> data) {
                invokeListener(ListenerTypeEnum.RefreshConversation, data);
            }

            @Override
            public void onError(int code, String desc) {
                Log.d(TencentImPlugin.TAG, "getUsersProfile failed, code: " + code + "|descr: " + desc);
            }
        }, list);
    }

    /**
     * 消息撤回
     */
    @Override
    public void onMessageRevoked(TIMMessageLocator timMessageLocator) {
        invokeListener(ListenerTypeEnum.MessageRevoked, timMessageLocator);
    }

    /**
     * 已读消息通知
     *
     * @param list 消息列表
     */
    @Override
    public void onRecvReceipt(List<TIMMessageReceipt> list) {
        List<String> rs = new ArrayList<>(list.size());
        for (TIMMessageReceipt timMessageReceipt : list) {
            rs.add(timMessageReceipt.getConversation().getPeer());
        }
        invokeListener(ListenerTypeEnum.RecvReceipt, rs);
    }

    /**
     * 新消息通知
     *
     * @param list 消息列表
     * @return 默认情况下所有消息监听器都将按添加顺序被回调一次，除非用户在 onNewMessages 回调中返回 true，此时将不再继续回调下一个消息监听器
     */
    @Override
    public boolean onNewMessages(List<TIMMessage> list) {
        TencentImUtils.getMessageInfo(list, new ValueCallBack<List<MessageEntity>>(null) {
            @Override
            public void onSuccess(List<MessageEntity> messageEntities) {
                invokeListener(ListenerTypeEnum.NewMessages, messageEntities);
            }

            @Override
            public void onError(int code, String desc) {
                Log.d(TencentImPlugin.TAG, "getUsersProfile failed, code: " + code + "|descr: " + desc);
            }
        });
        return false;
    }

    /**
     * 上传进度改变
     *
     * @param timMessage 消息对象
     * @param elemId     节点ID
     * @param taskId     任务ID
     * @param progress   进程
     */
    @Override
    public void onMessagesUpdate(TIMMessage timMessage, final int elemId, final int taskId, int progress) {
        final int finalProgress = progress;
        TencentImUtils.getMessageInfo(Collections.singletonList(timMessage), new ValueCallBack<List<MessageEntity>>(null) {
            @Override
            public void onSuccess(List<MessageEntity> messageEntities) {
                Map<String, Object> params = new HashMap<>(4, 1);
                params.put("message", messageEntities.get(0));
                params.put("elemId", elemId);
                params.put("taskId", taskId);
                params.put("progress", finalProgress);
                invokeListener(ListenerTypeEnum.UploadProgress, params);
            }

            @Override
            public void onError(int code, String desc) {
                Log.d(TencentImPlugin.TAG, "getUsersProfile failed, code: " + code + "|descr: " + desc);
            }
        });
    }
}
