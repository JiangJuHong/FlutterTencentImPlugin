import ImSDK
//  Created by 蒋具宏 on 2020/2/15.
//  腾讯云监听器

public class TencentImListener : NSObject,TIMUserStatusListener,TIMConnListener,TIMGroupEventListener,TIMRefreshListener,TIMMessageRevokeListener,TIMMessageReceiptListener,TIMMessageListener{
    
    var channel : FlutterMethodChannel;
    
    /**
     * 监听器回调的方法名
     */
    private static let LISTENER_FUNC_NAME = "onListener";
    
    init(channel : FlutterMethodChannel) {
        self.channel = channel;
    }
    
    /**
     * 调用监听器
     *
     * @param type   类型
     * @param params 参数
     */
    private func invokeListener(type : ListenerType, params : Any?) {
        var resultParams : [String:Any] = [:];
        resultParams["type"] = type;
        resultParams["params"] = params == nil ? nil : JsonUtil.toJson(params!);
        channel.invokeMethod(TencentImListener.LISTENER_FUNC_NAME, arguments: JsonUtil.toJson(resultParams));
    }
    
    /**
     * 踢下线通知
     */
    public func onForceOffline() {
        self.invokeListener(type: ListenerType.ForceOffline, params: nil);
    }
    
    /**
     * 断线重连失败【IOS独享】
     */
    public func onReConnFailed(_ code: Int32, err: String!) {
        self.invokeListener(type: ListenerType.Disconnected, params: ["code":code,"msg":err!]);
    }
    
    /**
     * 用户登录的 userSig 过期（用户需要重新获取 userSig 后登录）
     */
    public func onUserSigExpired() {
        self.invokeListener(type: ListenerType.UserSigExpired, params: nil);
    }
    
    /**
     * 网络连接成功
     */
    public func onConnSucc() {
        self.invokeListener(type: ListenerType.Connected, params: nil);
    }
    
    /**
     * 网络连接失败【IOS独享】
     */
    public func onConnFailed(_ code: Int32, err: String!) {
        self.invokeListener(type: ListenerType.ConnFailed, params: ["code":code,"msg":err!]);
    }
    
    /**
     * 网络连接断开（断线只是通知用户，不需要重新登录，重连以后会自动上线）
     */
    public func onDisconnect(_ code: Int32, err: String!) {
        self.invokeListener(type: ListenerType.Disconnected, params: ["code":code,"msg":err!]);
    }
    
    /**
     * 连接中【IOS独享】
     */
    public func onConnecting() {
        self.invokeListener(type: ListenerType.Connecting, params: nil);
    }
    
    /**
     * 群Tips回调
     */
    public func onGroupTipsEvent(_ elem: TIMGroupTipsElem!) {
        self.invokeListener(type: ListenerType.GroupTips, params: GroupTipsNodeEntity(elem: elem));
    }
    
    /**
     * 刷新会话
     */
    public func onRefresh() {
        self.invokeListener(type: ListenerType.Refresh, params: nil);
    }
    
    /**
     * 刷新部分会话
     */
    public func onRefreshConversations(_ conversations: [TIMConversation]!) {
        // 获取资料后调用回调
        TencentImUtils.getConversationInfo(conversations: conversations, onSuccess: {
            (array) -> Void in
            self.invokeListener(type: ListenerType.RefreshConversation, params: array);
        }, onFail: {_,_ in
            
        });
    }
    
    /**
     * 消息撤回通知
     */
    public func onRevokeMessage(_ locator: TIMMessageLocator!) {
        self.invokeListener(type: ListenerType.MessageRevoked, params: MessageLocatorEntity(locator: locator));
    }
    
    /**
     * 收到了已读回执
     */
    public func onRecvMessageReceipts(_ receipts: [Any]!) {
        var rs : [String] = [];
        
        for item in receipts{
            rs.append((item as! TIMMessageReceipt).conversation.getReceiver());
        }
        
        self.invokeListener(type: ListenerType.RecvReceipt, params: rs);
    }
    
    /**
     * 新消息回调通知
     */
    public func onNewMessage(_ msgs: [Any]!) {
        TencentImUtils.getMessageInfo(timMessages: msgs as! [TIMMessage], onSuccess:{
            (array) -> Void in
            self.invokeListener(type: ListenerType.NewMessages, params: array);
        }, onFail: {_,_ in })
    }
}
