package top.huic.tencent_im_plugin.enums;

/**
 * 监听器类型枚举
 */
public enum ListenerTypeEnum {

    /**
     * 被踢下线
     */
    ForceOffline,

    /**
     * 用户签名过期，需要重新登录
     */
    UserSigExpired,

    /**
     * 连接
     */
    Connected,

    /**
     * 断开连接
     */
    Disconnected,

    /**
     * Wifi需要认证【Android独享】
     */
    WifiNeedAuth,

    /**
     * 会话刷新
     */
    Refresh,

    /**
     * 会话刷新
     */
    RefreshConversation,

    /**
     * 消息撤回
     */
    MessageRevoked,

    /**
     * 新消息通知
     */
    NewMessages,

    /**
     * 群消息
     */
    GroupTips,

    /**
     * 已读
     */
    RecvReceipt,

    /**
     * 上传进度
     */
    UploadProgress,

    /**
     * 下载进度
     */
    DownloadProgress,
}
