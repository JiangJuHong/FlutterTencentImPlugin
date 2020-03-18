//  Created by 蒋具宏 on 2020/2/15.
//  监听器类型
public enum ListenerType{
    /**
     * 被踢下线
     */
    case ForceOffline
    
    /**
     * 用户签名过期，需要重新登录
     */
    case UserSigExpired
    
    /**
     * 连接
     */
    case Connected
    
    /**
     * 断开连接
     */
    case Disconnected
    
    /**
     * 会话刷新
     */
    case Refresh
    
    /**
     * 会话刷新
     */
    case RefreshConversation
    
    /**
     * 消息撤回
     */
    case MessageRevoked
    
    /**
     * 新消息通知
     */
    case NewMessages
    
    /**
     * 群消息
     */
    case GroupTips
    /**
     * 已读
     */
    case RecvReceipt
    
    /**
     * 断线重连失败【IOS独享】
     */
    case ReConnFailed
    
    /**
     * 网络连接失败【IOS独享】
     */
    case ConnFailed
    
    /**
     * 连接中【IOS独享】
     */
    case Connecting

    /**
     *  上传进度
     */
    case UploadProgress
    
    /**
     *  下载进度
     */
    case DownloadProgress
}
