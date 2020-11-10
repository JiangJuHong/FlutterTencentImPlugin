package top.huic.tencent_im_plugin.listener;

import com.tencent.imsdk.v2.V2TIMSDKListener;
import com.tencent.imsdk.v2.V2TIMUserFullInfo;

import java.util.HashMap;

import top.huic.tencent_im_plugin.TencentImPlugin;
import top.huic.tencent_im_plugin.enums.ListenerTypeEnum;

/**
 * SDK基本监听器
 */
public class CustomSDKListener extends V2TIMSDKListener {
    /**
     * 正在连接到腾讯云服务器
     */
    @Override
    public void onConnecting() {
        super.onConnecting();
        TencentImPlugin.invokeListener(ListenerTypeEnum.Connecting, null);
    }

    /**
     * 网络连接成功
     */
    @Override
    public void onConnectSuccess() {
        super.onConnectSuccess();
        TencentImPlugin.invokeListener(ListenerTypeEnum.ConnectSuccess, null);
    }

    /**
     * 网络连接失败
     */
    @Override
    public void onConnectFailed(final int code, final String error) {
        super.onConnectFailed(code, error);
        TencentImPlugin.invokeListener(ListenerTypeEnum.ConnectFailed, new HashMap<String, Object>() {
            {
                put("code", code);
                put("error", error);
            }
        });
    }

    /**
     * 踢下线通知
     */
    @Override
    public void onKickedOffline() {
        super.onKickedOffline();
        TencentImPlugin.invokeListener(ListenerTypeEnum.KickedOffline, null);
    }

    /**
     * 当前用户的资料发生了更新
     */
    @Override
    public void onSelfInfoUpdated(V2TIMUserFullInfo info) {
        super.onSelfInfoUpdated(info);
        TencentImPlugin.invokeListener(ListenerTypeEnum.SelfInfoUpdated, info);
    }

    /**
     * 用户登录的 userSig 过期（用户需要重新获取 userSig 后登录）
     */
    @Override
    public void onUserSigExpired() {
        super.onUserSigExpired();
        TencentImPlugin.invokeListener(ListenerTypeEnum.UserSigExpired, null);
    }
}
