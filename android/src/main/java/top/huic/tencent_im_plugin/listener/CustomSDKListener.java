package top.huic.tencent_im_plugin.listener;

import com.tencent.imsdk.v2.V2TIMSDKListener;
import com.tencent.imsdk.v2.V2TIMUserFullInfo;

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
}
