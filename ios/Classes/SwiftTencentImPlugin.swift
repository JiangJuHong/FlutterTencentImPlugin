import Flutter
import UIKit
import ImSDK

public class SwiftTencentImPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tencent_im_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftTencentImPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult){
        switch call.method {
        case "init":
            self.`init`(call: call, result: result)
            break
        case "login":
            self.login(call: call, result: result)
            break
        case "logout":
            self.logout(call: call, result: result)
            break
        case "getLoginUser":
            self.getLoginUser(call: call, result: result)
            break
        case "initStorage":
            self.initStorage(call: call, result: result)
            break
        case "getConversationList":
            getConversationList(call: call, result: result)
            break
        case "getGroupInfo":
            self.getGroupInfo(call: call, result: result);
            break;
        case "getUserInfo":
            self.getUserInfo(call: call, result: result);
            break;
        case "getMessages":
            self.getMessages(call: call, result: result);
            break;
        case "getLocalMessages":
            self.getLocalMessages(call: call, result: result);
            break;
        case "setRead":
            self.setRead(call: call, result: result);
            break;
        case "sendCustomMessage":
            self.sendCustomMessage(call: call, result: result);
            break;
        case "sendTextMessage":
            self.sendTextMessage(call: call, result: result);
            break;
        case "sendSoundMessage":
            self.sendSoundMessage(call: call, result: result);
            break;
        case "sendImageMessage":
            self.sendImageMessage(call: call, result: result);
            break;
        case "sendVideoMessage":
            self.sendVideoMessage(call: call, result: result);
            break;
        case "getFriendList":
            self.getFriendList(call: call, result: result);
            break;
        case "getGroupList":
            self.getGroupList(call: call, result: result);
            break;
        case "addFriend":
            self.addFriend(call: call, result: result);
            break;
        case "checkSingleFriends":
            self.checkSingleFriends(call: call, result: result);
            break;
        case "getPendencyList":
            self.getPendencyList(call: call, result: result);
            break;
        case "pendencyReport":
            self.pendencyReport(call: call, result: result);
            break;
        case "deletePendency":
            self.deletePendency(call: call, result: result);
            break;
        case "examinePendency":
            self.examinePendency(call: call, result: result);
            break;
        case "deleteConversation":
            self.deleteConversation(call: call, result: result);
            break;
        case "deleteLocalMessage":
            self.deleteLocalMessage(call: call, result: result);
            break;
        case "createGroup":
            self.createGroup(call: call, result: result);
            break;
        case "inviteGroupMember":
            self.inviteGroupMember(call: call, result: result);
            break;
        case "applyJoinGroup":
            self.applyJoinGroup(call: call, result: result);
            break;
        case "quitGroup":
            self.quitGroup(call: call, result: result);
            break;
        case "deleteGroupMember":
            self.deleteGroupMember(call: call, result: result);
            break;
        case "getGroupMembers":
            self.getGroupMembers(call: call, result: result);
            break;
        case "deleteGroup":
            self.deleteGroup(call: call, result: result);
            break;
        case "modifyGroupOwner":
            self.modifyGroupOwner(call: call, result: result);
        case "modifyGroupInfo":
            self.modifyGroupInfo(call: call, result: result);
            break;
        case "modifyMemberInfo":
            self.modifyMemberInfo(call: call, result: result);
            break;
        case "getGroupPendencyList":
            self.getGroupPendencyList(call: call, result: result);
            break;
        case "reportGroupPendency":
            self.reportGroupPendency(call: call, result: result);
            break;
        case "groupPendencyAccept":
            self.groupPendencyAccept(call: call, result: result);
            break;
        case "groupPendencyRefuse":
            self.groupPendencyRefuse(call: call, result: result);
            break;
        case "getSelfProfile":
            self.getSelfProfile(call: call, result: result);
            break;
        case "modifySelfProfile":
            self.modifySelfProfile(call: call, result: result);
            break;
        case "modifyFriend":
            self.modifyFriend(call: call, result: result);
            break;
        case "deleteFriends":
            self.deleteFriends(call: call, result: result);
            break;
        case "addBlackList":
            self.addBlackList(call: call, result: result);
            break;
        case "deleteBlackList":
            self.deleteBlackList(call: call, result: result);
            break;
        case "getBlackList":
            self.getBlackList(call: call, result: result);
            break;
        case "createFriendGroup":
            self.createFriendGroup(call: call, result: result);
            break;
        case "deleteFriendGroup":
            self.deleteFriendGroup(call: call, result: result);
            break;
        case "addFriendsToFriendGroup":
            self.addFriendsToFriendGroup(call: call, result: result);
            break;
        case "deleteFriendsFromFriendGroup":
            self.deleteFriendsFromFriendGroup(call: call, result: result);
            break;
        case "renameFriendGroup":
            self.renameFriendGroup(call: call, result: result);
            break;
        case "getFriendGroups":
            self.getFriendGroups(call: call, result: result);
            break;
        default:
            result(FlutterMethodNotImplemented);
        }
    }
    
    /**
     * 初始化腾讯云IM
     */
    public func `init`(call: FlutterMethodCall, result: @escaping FlutterResult){
        if let appid = CommonUtils.getParam(call: call, result: result, param: "appid"){
            // 初始化SDK配置
            let sdkConfig = TIMSdkConfig();
            sdkConfig.sdkAppId = (appid as NSString).intValue;
            // TODO 临时代码
            sdkConfig.disableLogPrint = true;
            sdkConfig.logLevel = TIMLogLevel.LOG_WARN;
            //            sdkConfig.logFunc =
            TIMManager.sharedInstance()?.initSdk(sdkConfig);
            
            // 初始化用户配置
            let userConfig = TIMUserConfig();
            userConfig.enableReadReceipt = true;
            TIMManager.sharedInstance()?.setUserConfig(userConfig);
            
            result(nil);
        }
    }
    
    /**
     * 登录
     */
    public func login(call: FlutterMethodCall, result: @escaping FlutterResult){
        if let identifier =  CommonUtils.getParam(call: call, result: result, param: "identifier") ,
            let userSig =  CommonUtils.getParam(call: call, result: result, param: "userSig")
        {
            // 如果已经登录，则不允许重复登录
            if TIMManager.sharedInstance()?.getLoginUser() != nil{
                result(
                    FlutterError(code: "login failed.", message: "user is login", details: "user is already login ,you should login out first")
                );
            }else{
                // 登录操作
                let loginParam = TIMLoginParam();
                loginParam.identifier = identifier;
                loginParam.userSig = userSig;
                //                int code, NSString * msg
                TIMManager.sharedInstance()?.login(loginParam, succ: {
                    result(nil);
                }, fail:TencentImUtils.returnErrorClosures(result: result))
            }
        }
    }
    
    /**
     * 登出
     */
    public func logout(call: FlutterMethodCall, result: @escaping FlutterResult){
        TIMManager.sharedInstance()?.logout({
            result(nil);
        },fail:TencentImUtils.returnErrorClosures(result: result));
    }
    
    /**
     * 获得当前登录用户
     */
    public func getLoginUser(call: FlutterMethodCall, result: @escaping FlutterResult){
        result(TIMManager.sharedInstance()?.getLoginUser());
    }
    
    /**
     * 初始化本地存储
     */
    public func initStorage(call: FlutterMethodCall, result: @escaping FlutterResult){
        if let identifier =  CommonUtils.getParam(call: call, result: result, param: "identifier")
        {
            TIMManager.sharedInstance()?.initStorage(identifier, succ: {
                result(nil);
            },fail:TencentImUtils.returnErrorClosures(result: result));
        }
        
    }
    
    /**
     * 获得当前登录用户会话列表
     */
    public func getConversationList(call: FlutterMethodCall, result: @escaping FlutterResult){
        var conversation = [TIMConversation] = TIMManager.sharedInstance()?.getConversationList()!;
        print(conversation)
    }
    
    /**
     * 获得群信息（先获取本地的，如果本地没有，则获取云端的）
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func getGroupInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 获得用户信息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func getUserInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 设置会话消息为已读
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func setRead(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    
    /**
     * 获得消息列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func getMessages(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 获得本地消息列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func getLocalMessages(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 发送自定义消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func sendCustomMessage(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 发送文本消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func sendTextMessage(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    
    /**
     * 发送语音消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func sendSoundMessage(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 发送图片消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func sendImageMessage(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 发送视频消息
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func sendVideoMessage(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 获得好友列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func getFriendList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 获得群组列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func getGroupList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 添加好友
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func addFriend(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 检测单个好友关系
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func checkSingleFriends(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 获得未决好友列表(申请中)
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func getPendencyList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 未决已读上报
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func pendencyReport(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 未决删除
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func deletePendency(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 未决审核
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func examinePendency(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 删除会话
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func deleteConversation(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 删除会话内的本地聊天记录
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func deleteLocalMessage(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 创建群组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func createGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 邀请加入群组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func inviteGroupMember(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 申请加入群组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func applyJoinGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 退出群组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func quitGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 删除群组成员
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func deleteGroupMember(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 获取群成员列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func getGroupMembers(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 解散群组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func deleteGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 转让群组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func modifyGroupOwner(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 修改群资料
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func modifyGroupInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 修改群成员资料
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func modifyMemberInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 获得未决群列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func getGroupPendencyList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 上报未决已读
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func reportGroupPendency(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 同意申请
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func groupPendencyAccept(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 拒绝申请
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func groupPendencyRefuse(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 获取自己的资料
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func getSelfProfile(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 修改自己的资料
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func modifySelfProfile(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 修改好友的资料
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func modifyFriend(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 删除好友
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func deleteFriends(call: FlutterMethodCall, result: @escaping FlutterResult) {
    }
    
    /**
     * 添加到黑名单
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func addBlackList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    
    /**
     * 从黑名单删除
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func deleteBlackList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 获得黑名单列表
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func getBlackList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 创建好友分组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func createFriendGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 删除好友分组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func deleteFriendGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 添加好友到某个分组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func addFriendsToFriendGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 从分组删除好友
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func deleteFriendsFromFriendGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 重命名分组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func renameFriendGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    /**
     * 获得好友分组
     *
     * @param methodCall 方法调用对象
     * @param result     返回结果对象
     */
    private func getFriendGroups(call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
}
