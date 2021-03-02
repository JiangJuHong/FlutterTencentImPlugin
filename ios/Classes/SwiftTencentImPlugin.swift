import Flutter
import UIKit
import ImSDK
import HandyJSON

public class SwiftTencentImPlugin: NSObject, FlutterPlugin {
    public static var channel: FlutterMethodChannel?;

    /* 下面是监听器列表，由于局部变量的监听器对象不会触发，所以提取为全局对象 */
    /// SDK 监听器
    private var customSdkListener = CustomSDKListener();

    /// 消息监听器
    private var customAdvancedMsgListener = CustomAdvancedMsgListener();

    /// 会话监听器
    private var customConversationListener = CustomConversationListener();

    /// 群组监听器
    private var customGroupListener = CustomGroupListener();

    /// 关系链相关监听器
    private var customFriendshipListener = CustomFriendshipListener();

    /// 信令监听器
    private var customSignalingListener = CustomSignalingListener();

    /// Apns离线推送监听器
    private var customAPNSListener = CustomAPNSListener();

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "tencent_im_plugin", binaryMessenger: registrar.messenger())
        let instance = SwiftTencentImPlugin()
        SwiftTencentImPlugin.channel = channel;
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "initSDK":
            self.`initSDK`(call: call, result: result)
            break
        case "unInitSDK":
            self.unInitSDK(call: call, result: result)
            break
        case "getVersion":
            self.getVersion(call: call, result: result)
            break
        case "getServerTime":
            self.getServerTime(call: call, result: result)
            break
        case "login":
            self.login(call: call, result: result)
            break
        case "logout":
            self.logout(call: call, result: result)
            break
        case "getLoginStatus":
            self.getLoginStatus(call: call, result: result)
            break
        case "getLoginUser":
            self.getLoginUser(call: call, result: result)
            break
        case "invite":
            self.invite(call: call, result: result)
            break
        case "inviteInGroup":
            self.inviteInGroup(call: call, result: result)
            break
        case "cancel":
            self.cancel(call: call, result: result)
            break
        case "accept":
            self.accept(call: call, result: result)
            break
        case "reject":
            self.reject(call: call, result: result)
            break
        case "getSignalingInfo":
            self.getSignalingInfo(call: call, result: result)
            break
        case "addInvitedSignaling":
            self.addInvitedSignaling(call: call, result: result)
            break
        case "sendMessage":
            self.sendMessage(call: call, result: result);
            break;
        case "resendMessage":
            self.resendMessage(call: call, result: result);
            break;
        case "revokeMessage":
            self.revokeMessage(call: call, result: result);
            break;
        case "getC2CHistoryMessageList":
            self.getC2CHistoryMessageList(call: call, result: result);
            break;
        case "getGroupHistoryMessageList":
            self.getGroupHistoryMessageList(call: call, result: result);
            break;
        case "getHistoryMessageList":
            self.getHistoryMessageList(call: call, result: result);
            break;
        case "markC2CMessageAsRead":
            self.markC2CMessageAsRead(call: call, result: result);
            break;
        case "markGroupMessageAsRead":
            self.markGroupMessageAsRead(call: call, result: result);
            break;
        case "deleteMessageFromLocalStorage":
            self.deleteMessageFromLocalStorage(call: call, result: result);
            break;
        case "deleteMessages":
            self.deleteMessages(call: call, result: result);
            break;
        case "insertGroupMessageToLocalStorage":
            self.insertGroupMessageToLocalStorage(call: call, result: result);
            break;
        case "downloadVideo":
            self.downloadVideo(call: call, result: result);
            break;
        case "downloadVideoThumbnail":
            self.downloadVideoThumbnail(call: call, result: result);
            break;
        case "downloadSound":
            self.downloadSound(call: call, result: result);
            break;
        case "downloadFile":
            self.downloadFile(call: call, result: result);
            break;
        case "setMessageLocalCustomStr":
            self.setMessageLocalCustomStr(call: call, result: result);
            break;
        case "setMessageLocalCustomInt":
            self.setMessageLocalCustomInt(call: call, result: result);
            break;
        case "findMessages":
            self.findMessages(call: call, result: result);
            break;
        case "createGroup":
            self.createGroup(call: call, result: result);
            break;
        case "joinGroup":
            self.joinGroup(call: call, result: result);
            break;
        case "quitGroup":
            self.quitGroup(call: call, result: result);
            break;
        case "dismissGroup":
            self.dismissGroup(call: call, result: result);
            break;
        case "getJoinedGroupList":
            self.getJoinedGroupList(call: call, result: result);
            break;
        case "getGroupsInfo":
            self.getGroupsInfo(call: call, result: result);
            break;
        case "setGroupInfo":
            self.setGroupInfo(call: call, result: result);
            break;
        case "setReceiveMessageOpt":
            self.setReceiveMessageOpt(call: call, result: result);
            break;
        case "initGroupAttributes":
            self.initGroupAttributes(call: call, result: result);
            break;
        case "setGroupAttributes":
            self.setGroupAttributes(call: call, result: result);
            break;
        case "deleteGroupAttributes":
            self.deleteGroupAttributes(call: call, result: result);
            break;
        case "getGroupAttributes":
            self.getGroupAttributes(call: call, result: result);
            break;
        case "getGroupOnlineMemberCount":
            self.getGroupOnlineMemberCount(call: call, result: result);
            break;
        case "getGroupMemberList":
            self.getGroupMemberList(call: call, result: result);
            break;
        case "getGroupMembersInfo":
            self.getGroupMembersInfo(call: call, result: result);
            break;
        case "setGroupMemberInfo":
            self.setGroupMemberInfo(call: call, result: result);
            break;
        case "muteGroupMember":
            self.muteGroupMember(call: call, result: result);
            break;
        case "inviteUserToGroup":
            self.inviteUserToGroup(call: call, result: result);
            break;
        case "kickGroupMember":
            self.kickGroupMember(call: call, result: result);
            break;
        case "setGroupMemberRole":
            self.setGroupMemberRole(call: call, result: result);
            break;
        case "transferGroupOwner":
            self.transferGroupOwner(call: call, result: result);
            break;
        case "getGroupApplicationList":
            self.getGroupApplicationList(call: call, result: result);
            break;
        case "acceptGroupApplication":
            self.acceptGroupApplication(call: call, result: result);
            break;
        case "refuseGroupApplication":
            self.refuseGroupApplication(call: call, result: result);
            break;
        case "setGroupApplicationRead":
            self.setGroupApplicationRead(call: call, result: result);
            break;
        case "getConversationList":
            self.getConversationList(call: call, result: result);
            break;
        case "getConversation":
            self.getConversation(call: call, result: result);
            break;
        case "deleteConversation":
            self.deleteConversation(call: call, result: result);
            break;
        case "setConversationDraft":
            self.setConversationDraft(call: call, result: result);
            break;
        case "getUsersInfo":
            self.getUsersInfo(call: call, result: result);
            break;
        case "setSelfInfo":
            self.setSelfInfo(call: call, result: result);
            break;
        case "addToBlackList":
            self.addToBlackList(call: call, result: result);
            break;
        case "deleteFromBlackList":
            self.deleteFromBlackList(call: call, result: result);
            break;
        case "getBlackList":
            self.getBlackList(call: call, result: result);
            break;
        case "setOfflinePushConfig":
            self.setOfflinePushConfig(call: call, result: result);
            break;
        case "setUnreadBadge":
            self.setUnreadBadge(call: call, result: result);
            break;
        case "getFriendList":
            self.getFriendList(call: call, result: result);
            break;
        case "getFriendsInfo":
            self.getFriendsInfo(call: call, result: result);
            break;
        case "setFriendInfo":
            self.setFriendInfo(call: call, result: result);
            break;
        case "addFriend":
            self.addFriend(call: call, result: result);
            break;
        case "deleteFromFriendList":
            self.deleteFromFriendList(call: call, result: result);
            break;
        case "checkFriend":
            self.checkFriend(call: call, result: result);
            break;
        case "getFriendApplicationList":
            self.getFriendApplicationList(call: call, result: result);
            break;
        case "acceptFriendApplication":
            self.acceptFriendApplication(call: call, result: result);
            break;
        case "refuseFriendApplication":
            self.refuseFriendApplication(call: call, result: result);
            break;
        case "deleteFriendApplication":
            self.deleteFriendApplication(call: call, result: result);
            break;
        case "setFriendApplicationRead":
            self.setFriendApplicationRead(call: call, result: result);
            break;
        case "createFriendGroup":
            self.createFriendGroup(call: call, result: result);
            break;
        case "getFriendGroups":
            self.getFriendGroups(call: call, result: result);
            break;
        case "deleteFriendGroup":
            self.deleteFriendGroup(call: call, result: result);
            break;
        case "renameFriendGroup":
            self.renameFriendGroup(call: call, result: result);
            break;
        case "addFriendsToFriendGroup":
            self.addFriendsToFriendGroup(call: call, result: result);
            break;
        case "deleteFriendsFromFriendGroup":
            self.deleteFriendsFromFriendGroup(call: call, result: result);
            break;
        default:
            result(FlutterMethodNotImplemented);
        }
    }

    /**
     * 初始化腾讯云IM
     */
    public func `initSDK`(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let logPrintLevel = ((call.arguments as! [String: Any])["logPrintLevel"]) as? Int;
        if let appid = CommonUtils.getParam(call: call, result: result, param: "appid") as? String {

            // 初始化SDK配置
            let sdkConfig = V2TIMSDKConfig();
            if logPrintLevel != nil {
                sdkConfig.logLevel = V2TIMLogLevel.init(rawValue: logPrintLevel!)!;
            }

            V2TIMManager.sharedInstance().initSDK((appid as NSString).intValue, config: sdkConfig, listener: customSdkListener)

            // 绑定消息监听
            V2TIMManager.sharedInstance()?.addAdvancedMsgListener(listener: customAdvancedMsgListener)

            // 绑定会话监听
            V2TIMManager.sharedInstance().setConversationListener(customConversationListener)

            // 绑定群监听
            V2TIMManager.sharedInstance().setGroupListener(customGroupListener)

            // 绑定关系链监听
            V2TIMManager.sharedInstance().setFriendListener(customFriendshipListener)

            // 绑定信令监听
            V2TIMManager.sharedInstance().addSignalingListener(listener: customSignalingListener)

            // 绑定APNS监听
            V2TIMManager.sharedInstance().setAPNSListener(customAPNSListener)

            result(nil);
        }
    }


    /// 反初始化
    public func unInitSDK(call: FlutterMethodCall, result: @escaping FlutterResult) {
        V2TIMManager.sharedInstance().unInitSDK();
        V2TIMManager.sharedInstance()?.removeAdvancedMsgListener(listener: customAdvancedMsgListener)
        V2TIMManager.sharedInstance()?.removeSignalingListener(listener: customSignalingListener)
        result(nil);
    }

    /// 获得SDK版本
    public func getVersion(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(V2TIMManager.sharedInstance()?.getVersion()!);
    }

    /// 获取服务器当前时间
    public func getServerTime(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(V2TIMManager.sharedInstance()?.getServerTime());
    }

    /// 登录
    func login(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userID = CommonUtils.getParam(call: call, result: result, param: "userID") as? String,
           let userSig = CommonUtils.getParam(call: call, result: result, param: "userSig") as? String {
            V2TIMManager.sharedInstance().login(userID, userSig: userSig, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 登出
    public func logout(call: FlutterMethodCall, result: @escaping FlutterResult) {
        V2TIMManager.sharedInstance()?.logout({
            result(nil);
        }, fail: TencentImUtils.returnErrorClosures(result: result));
    }

    /// 获得登录状态
    public func getLoginStatus(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(V2TIMManager.sharedInstance().getLoginStatus().rawValue);
    }

    /// 获得当前登录用户
    public func getLoginUser(call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(V2TIMManager.sharedInstance()?.getLoginUser());
    }

    /// 邀请某个人
    public func invite(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let invitee = CommonUtils.getParam(call: call, result: result, param: "invitee") as? String,
           let data = CommonUtils.getParam(call: call, result: result, param: "data") as? String,
           let onlineUserOnly = CommonUtils.getParam(call: call, result: result, param: "onlineUserOnly") as? Bool,
           let offlinePushInfo = CommonUtils.getParam(call: call, result: result, param: "offlinePushInfo") as? String,
           let timeout = CommonUtils.getParam(call: call, result: result, param: "timeout") as? Int32 {
            result(V2TIMManager.sharedInstance().invite(invitee, data: data, onlineUserOnly: onlineUserOnly, offlinePushInfo: CustomOfflinePushInfoEntity.init(jsonStr: offlinePushInfo), timeout: timeout, succ: {
                () -> Void in
            }, fail: {
                (code: Int32, desc: Optional<String>) -> Void in
            }))
        }
    }

    /// 邀请群内的某些人
    public func inviteInGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let data = CommonUtils.getParam(call: call, result: result, param: "data") as? String,
           let inviteeList = CommonUtils.getParam(call: call, result: result, param: "inviteeList") as? String,
           let onlineUserOnly = CommonUtils.getParam(call: call, result: result, param: "onlineUserOnly") as? Bool,
           let timeout = CommonUtils.getParam(call: call, result: result, param: "timeout") as? Int32 {

            // 邀请
            result(V2TIMManager.sharedInstance().invite(inGroup: groupID, inviteeList: inviteeList.split(separator: ","), data: data, onlineUserOnly: onlineUserOnly, timeout: timeout, succ: {
                () -> Void in
            }, fail: {
                (code: Int32, desc: Optional<String>) -> Void in
            }))
        }
    }

    /// 邀请方取消邀请
    public func cancel(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let inviteID = CommonUtils.getParam(call: call, result: result, param: "inviteID") as? String,
           let data = CommonUtils.getParam(call: call, result: result, param: "data") as? String {
            V2TIMManager.sharedInstance().cancel(inviteID, data: data, succ: {
                () -> Void in
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 接收方接收邀请
    public func accept(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let inviteID = CommonUtils.getParam(call: call, result: result, param: "inviteID") as? String,
           let data = CommonUtils.getParam(call: call, result: result, param: "data") as? String {
            V2TIMManager.sharedInstance().accept(inviteID, data: data, succ: {
                () -> Void in
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 接收方拒绝邀请
    public func reject(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let inviteID = CommonUtils.getParam(call: call, result: result, param: "inviteID") as? String,
           let data = CommonUtils.getParam(call: call, result: result, param: "data") as? String {
            V2TIMManager.sharedInstance().reject(inviteID, data: data, succ: {
                () -> Void in
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 获得信令信息
    public func getSignalingInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let messageStr = CommonUtils.getParam(call: call, result: result, param: "message") as? String {
            TencentImUtils.getMessageByFindMessageEntity(json: messageStr, succ: {
                (messages: V2TIMMessage?) in
                result(JsonUtil.toJson(CustomSignalingInfoEntity.getDict(info: V2TIMManager.sharedInstance().getSignallingInfo(messages!))));
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 添加邀请信令（可以用于群离线推送消息触发的邀请信令）
    public func addInvitedSignaling(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let info = CommonUtils.getParam(call: call, result: result, param: "info") as? String {
            V2TIMManager.sharedInstance().addInvitedSignaling(CustomSignalingInfoEntity.init(jsonStr: info), succ: {
                () -> Void in
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 发送消息
    private func sendMessage(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let nodeStr = CommonUtils.getParam(call: call, result: result, param: "node") as? String {
            // 将节点信息解析
            let node = JsonUtil.getDictionaryFromJSONString(jsonString: nodeStr);

            // 获得发送消息体
            let message: V2TIMMessage = MessageNodeType.getMessageNodeTypeByV2TIMConstant(constant: node["nodeType"] as! Int).messageNodeInterface().getV2TIMMessage(params: node);
            self._sendMessage(message: message, call: call, result: result);
        }
    }


    /// 重发消息
    public func resendMessage(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let messageStr = CommonUtils.getParam(call: call, result: result, param: "message") as? String {
            TencentImUtils.getMessageByFindMessageEntity(json: messageStr, succ: {
                (message: V2TIMMessage?) in
                self._sendMessage(message: message!, call: call, result: result);
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 发送消息
    /// - Parameters:
    ///   - message: 消息对象
    ///   - call: Flutter 方法调用对象
    ///   - result: Flutter 返回结果对象
    private func _sendMessage(message: V2TIMMessage, call: FlutterMethodCall, result: @escaping FlutterResult) {
        let receiver = ((call.arguments as! [String: Any])["receiver"]) as? String;
        let groupID = ((call.arguments as! [String: Any])["groupID"]) as? String;
        let localCustomInt = ((call.arguments as! [String: Any])["localCustomInt"]) as? Int32;
        let localCustomStr = ((call.arguments as! [String: Any])["localCustomStr"]) as? String;
        let offlinePushInfo = ((call.arguments as! [String: Any])["offlinePushInfo"]) as? String;
        if let ol = CommonUtils.getParam(call: call, result: result, param: "ol") as? Bool,
           let priority = CommonUtils.getParam(call: call, result: result, param: "priority") as? Int {
            if localCustomInt != nil {
                message.localCustomInt = localCustomInt!;
            }
            if localCustomStr != nil {
                message.localCustomData = localCustomStr!.data(using: .utf8);
            }

            var msgId: [String?] = [nil];
            // 成功回调
            let _sendSuccess = {
                TencentImUtils.getMessageByFindMessageEntity(dict: ["msgId": msgId[0]], succ: {
                    (message: V2TIMMessage?) -> () in
                    SwiftTencentImPlugin.invokeListener(type: ListenerType.MessageSendSucc, params: MessageEntity.init(message: message!))
                }, fail: { (int32: Int32, s: String?) -> () in })
            };

            // 进度回调
            let _progress = {
                (p: UInt32) in
                SwiftTencentImPlugin.invokeListener(type: ListenerType.MessageSendProgress, params: [
                    "msgId": msgId[0]!,
                    "progress": p,
                ])
            };

            // 失败回调
            let _fail = {
                (code: Int32, desc: Optional<String>) -> Void in
                SwiftTencentImPlugin.invokeListener(type: ListenerType.MessageSendFail, params: [
                    "msgId": msgId[0]!,
                    "code": code,
                    "desc": desc,
                ])
            };

            // 发送消息
            msgId[0] = V2TIMManager.sharedInstance().send(message, receiver: receiver, groupID: groupID, priority: V2TIMMessagePriority.init(rawValue: priority)!, onlineUserOnly: ol, offlinePushInfo: CustomOfflinePushInfoEntity.init(jsonStr: offlinePushInfo), progress: _progress, succ: _sendSuccess, fail: _fail)
            result(msgId[0]);
        }
    }

    /// 撤回消息
    public func revokeMessage(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let messageStr = CommonUtils.getParam(call: call, result: result, param: "message") as? String {
            TencentImUtils.getMessageByFindMessageEntity(json: messageStr, succ: {
                (messages: V2TIMMessage?) in
                V2TIMManager.sharedInstance().revokeMessage(messages!, succ: {
                    result(nil);
                }, fail: TencentImUtils.returnErrorClosures(result: result))
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 获得单聊历史记录
    public func getC2CHistoryMessageList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let lastMsg = ((call.arguments as! [String: Any])["lastMsg"]) as? String;
        if let userID = CommonUtils.getParam(call: call, result: result, param: "userID") as? String,
           let count = CommonUtils.getParam(call: call, result: result, param: "count") as? Int32 {

            // 返回结果对象
            let resultCallBack = {
                (messages: [V2TIMMessage]?) in
                var resultData: [MessageEntity] = [];
                for item in messages! {
                    resultData.append(MessageEntity.init(message: item));
                }
                result(JsonUtil.toJson(resultData));
            };

            // 根据消息对象是否为null进行不同的操作
            if lastMsg == nil {
                V2TIMManager.sharedInstance().getC2CHistoryMessageList(userID, count: count, lastMsg: nil, succ: resultCallBack, fail: TencentImUtils.returnErrorClosures(result: result))
            } else {
                TencentImUtils.getMessageByFindMessageEntity(json: lastMsg!, succ: {
                    (messages: V2TIMMessage?) in
                    V2TIMManager.sharedInstance().getC2CHistoryMessageList(userID, count: count, lastMsg: messages!, succ: resultCallBack, fail: TencentImUtils.returnErrorClosures(result: result))
                }, fail: TencentImUtils.returnErrorClosures(result: result));
            }
        }
    }

    /// 获得群聊历史记录
    public func getGroupHistoryMessageList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let lastMsg = ((call.arguments as! [String: Any])["lastMsg"]) as? String;
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let count = CommonUtils.getParam(call: call, result: result, param: "count") as? Int32 {
            // 返回结果对象
            let resultCallBack = {
                (messages: [V2TIMMessage]?) in
                var resultData: [MessageEntity] = [];
                for item in messages! {
                    resultData.append(MessageEntity.init(message: item));
                }
                result(JsonUtil.toJson(resultData));
            };

            // 根据消息对象是否为null进行不同的操作
            if lastMsg == nil {
                V2TIMManager.sharedInstance().getGroupHistoryMessageList(groupID, count: count, lastMsg: nil, succ: resultCallBack, fail: TencentImUtils.returnErrorClosures(result: result))
            } else {
                TencentImUtils.getMessageByFindMessageEntity(json: lastMsg!, succ: {
                    (messages: V2TIMMessage?) in
                    V2TIMManager.sharedInstance().getGroupHistoryMessageList(groupID, count: count, lastMsg: messages!, succ: resultCallBack, fail: TencentImUtils.returnErrorClosures(result: result))
                }, fail: TencentImUtils.returnErrorClosures(result: result));
            }
        }
    }

    /// 获得历史记录
    public func getHistoryMessageList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let lastMsg = ((call.arguments as! [String: Any])["lastMsg"]) as? String;
        let groupID = ((call.arguments as! [String: Any])["groupID"]) as? String;
        let userID = ((call.arguments as! [String: Any])["userID"]) as? String;
        if let type = CommonUtils.getParam(call: call, result: result, param: "type") as? Int,
           let count = CommonUtils.getParam(call: call, result: result, param: "count") as? Int32 {
            // 返回结果对象
            let resultCallBack = {
                (messages: [V2TIMMessage]?) in
                var resultData: [MessageEntity] = [];
                for item in messages! {
                    resultData.append(MessageEntity.init(message: item));
                }
                result(JsonUtil.toJson(resultData));
            };

            // 根据消息对象是否为null进行不同的操作
            let opt = V2TIMMessageListGetOption();
            if let v = userID {
                opt.userID = v;
            }
            if let v = groupID {
                opt.groupID = v;
            }
            opt.count = count;
            opt.getType = V2TIMMessageGetType.init(rawValue: type)!;
            if lastMsg == nil {
                V2TIMManager.sharedInstance()?.getHistoryMessageList(opt, succ: resultCallBack, fail: TencentImUtils.returnErrorClosures(result: result))
            } else {
                TencentImUtils.getMessageByFindMessageEntity(json: lastMsg!, succ: {
                    (messages: V2TIMMessage?) in
                    if let v = messages {
                        opt.lastMsg = messages!;
                    }
                    V2TIMManager.sharedInstance()?.getHistoryMessageList(opt, succ: resultCallBack, fail: TencentImUtils.returnErrorClosures(result: result))
                }, fail: TencentImUtils.returnErrorClosures(result: result));
            }
        }
    }

    /// 设置单聊已读
    public func markC2CMessageAsRead(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userID = CommonUtils.getParam(call: call, result: result, param: "userID") as? String {
            V2TIMManager.sharedInstance().markC2CMessage(asRead: userID, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 设置群聊已读
    public func markGroupMessageAsRead(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String {
            V2TIMManager.sharedInstance().markGroupMessage(asRead: groupID, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 删除本地消息
    public func deleteMessageFromLocalStorage(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let message = CommonUtils.getParam(call: call, result: result, param: "message") as? String {
            TencentImUtils.getMessageByFindMessageEntity(json: message, succ: {
                (messages: V2TIMMessage?) in
                V2TIMManager.sharedInstance().deleteMessage(fromLocalStorage: messages!, succ: {
                    result(nil);
                }, fail: TencentImUtils.returnErrorClosures(result: result))
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 删除本地及漫游消息
    public func deleteMessages(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let message = CommonUtils.getParam(call: call, result: result, param: "message") as? String {
            let arr = JsonUtil.getArrayFromJSONString(jsonString: message);
            TencentImUtils.getMessageByFindMessageEntity(dict: arr as! [[String: Any]], succ: {
                (messages: [V2TIMMessage]?) in
                V2TIMManager.sharedInstance().delete(messages!, succ: {
                    result(nil);
                }, fail: TencentImUtils.returnErrorClosures(result: result))
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 向群组消息列表中添加一条消息
    public func insertGroupMessageToLocalStorage(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let sender = CommonUtils.getParam(call: call, result: result, param: "sender") as? String,
           let nodeStr = CommonUtils.getParam(call: call, result: result, param: "node") as? String {

            // 将节点信息解析
            let node = JsonUtil.getDictionaryFromJSONString(jsonString: nodeStr);

            // 获得消息体
            let message: V2TIMMessage = MessageNodeType.getMessageNodeTypeByV2TIMConstant(constant: node["nodeType"] as! Int).messageNodeInterface().getV2TIMMessage(params: node);

            // 添加到列表
            V2TIMManager.sharedInstance().insertGroupMessage(toLocalStorage: message, to: groupID, sender: sender, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 下载视频
    public func downloadVideo(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let message = CommonUtils.getParam(call: call, result: result, param: "message") as? String,
           let path = CommonUtils.getParam(call: call, result: result, param: "path") as? String {
            TencentImUtils.getMessageByFindMessageEntity(json: message, succ: {
                (msg: V2TIMMessage?) in
                msg?.videoElem?.downloadVideo(path, progress: {
                    curSize, totalSize in
                    SwiftTencentImPlugin.invokeListener(type: ListenerType.DownloadProgress, params: [
                        "msgId": msg!.msgID!,
                        "currentSize": curSize,
                        "totalSize": totalSize,
                        "type": DownloadType.Video.rawValue,
                    ])
                }, succ: {
                    result(path);
                }, fail: TencentImUtils.returnErrorClosures(result: result));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 下载视频缩略图
    public func downloadVideoThumbnail(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let message = CommonUtils.getParam(call: call, result: result, param: "message") as? String,
           let path = CommonUtils.getParam(call: call, result: result, param: "path") as? String {
            TencentImUtils.getMessageByFindMessageEntity(json: message, succ: {
                (msg: V2TIMMessage?) in
                msg?.videoElem?.downloadSnapshot(path, progress: {
                    curSize, totalSize in
                    SwiftTencentImPlugin.invokeListener(type: ListenerType.DownloadProgress, params: [
                        "msgId": msg!.msgID!,
                        "currentSize": curSize,
                        "totalSize": totalSize,
                        "type": DownloadType.VideoThumbnail.rawValue,
                    ])
                }, succ: {
                    result(path);
                }, fail: TencentImUtils.returnErrorClosures(result: result));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 下载语音
    public func downloadSound(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let message = CommonUtils.getParam(call: call, result: result, param: "message") as? String,
           let path = CommonUtils.getParam(call: call, result: result, param: "path") as? String {
            TencentImUtils.getMessageByFindMessageEntity(json: message, succ: {
                (msg: V2TIMMessage?) in
                msg?.soundElem?.downloadSound(path, progress: {
                    curSize, totalSize in
                    SwiftTencentImPlugin.invokeListener(type: ListenerType.DownloadProgress, params: [
                        "msgId": msg!.msgID!,
                        "currentSize": curSize,
                        "totalSize": totalSize,
                        "type": DownloadType.Sound.rawValue,
                    ])
                }, succ: {
                    result(path);
                }, fail: TencentImUtils.returnErrorClosures(result: result));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 下载文件
    public func downloadFile(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let message = CommonUtils.getParam(call: call, result: result, param: "message") as? String,
           let path = CommonUtils.getParam(call: call, result: result, param: "path") as? String {
            TencentImUtils.getMessageByFindMessageEntity(json: message, succ: {
                (msg: V2TIMMessage?) in
                msg?.fileElem?.downloadFile(path, progress: {
                    curSize, totalSize in
                    SwiftTencentImPlugin.invokeListener(type: ListenerType.DownloadProgress, params: [
                        "msgId": msg!.msgID!,
                        "currentSize": curSize,
                        "totalSize": totalSize,
                        "type": DownloadType.File.rawValue,
                    ])
                }, succ: {
                    result(path);
                }, fail: TencentImUtils.returnErrorClosures(result: result));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 设置消息本地Str
    public func setMessageLocalCustomStr(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let message = CommonUtils.getParam(call: call, result: result, param: "message") as? String,
           let data = CommonUtils.getParam(call: call, result: result, param: "data") as? String {
            TencentImUtils.getMessageByFindMessageEntity(json: message, succ: {
                (msg: V2TIMMessage?) in
                msg!.localCustomData = data.data(using: .utf8)!;
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 设置消息本地Int
    public func setMessageLocalCustomInt(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let message = CommonUtils.getParam(call: call, result: result, param: "message") as? String,
           let data = CommonUtils.getParam(call: call, result: result, param: "data") as? Int32 {
            TencentImUtils.getMessageByFindMessageEntity(json: message, succ: {
                (msg: V2TIMMessage?) in
                msg!.localCustomInt = data;
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 查找消息列表
    public func findMessages(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let messages = CommonUtils.getParam(call: call, result: result, param: "messages") as? String {
            TencentImUtils.getMessageByFindMessageEntity(dict: JsonUtil.getArrayFromJSONString(jsonString: messages) as! [[String: Any]], succ: {
                (ms: [V2TIMMessage]!) in
                var res: [MessageEntity] = [];
                for item in ms! {
                    res.append(MessageEntity.init(message: item));
                }
                result(JsonUtil.toJson(res));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }


    /// 创建群
    public func createGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let memberList = ((call.arguments as! [String: Any])["memberList"]) as? String;
        if let info = CommonUtils.getParam(call: call, result: result, param: "info") as? String {

            // 初始化群创建群成员列表
            var ms: [CustomCreateGroupMemberEntity]? = nil;
            if memberList != nil {
                ms = [];
                let array = JsonUtil.getArrayFromJSONString(jsonString: memberList!);
                for index in 0..<array.count {
                    ms?.append(CustomCreateGroupMemberEntity(dict: array[index] as! [String: Any]));
                }
            }

            // 创建群
            V2TIMManager.sharedInstance().createGroup(CustomGroupInfoEntity(json: info), memberList: ms, succ: {
                s in
                result(s);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 加入群
    public func joinGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let message = CommonUtils.getParam(call: call, result: result, param: "message") as? String {
            V2TIMManager.sharedInstance().joinGroup(groupID, msg: message, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 退出群
    public func quitGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String {
            V2TIMManager.sharedInstance().quitGroup(groupID, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }


    /// 解散群
    public func dismissGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String {
            V2TIMManager.sharedInstance().dismissGroup(groupID, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 获得已加入的群列表
    public func getJoinedGroupList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        V2TIMManager.sharedInstance().getJoinedGroupList({
            infos in
            var resultData: [[String: Any]] = [];
            for item in infos! {
                resultData.append(CustomGroupInfoEntity.getDict(info: item))
            }
            result(JsonUtil.toJson(resultData));
        }, fail: TencentImUtils.returnErrorClosures(result: result))
    }


    /// 拉取群资料
    public func getGroupsInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupIDList = CommonUtils.getParam(call: call, result: result, param: "groupIDList") as? String {
            V2TIMManager.sharedInstance().getGroupsInfo(groupIDList.components(separatedBy: ","), succ: {
                infos in
                var resultData: [[String: Any]] = [];
                for item in infos! {
                    resultData.append(CustomGroupInfoResultEntity.getDict(info: item))
                }
                result(JsonUtil.toJson(resultData));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 修改群资料
    public func setGroupInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let info = CommonUtils.getParam(call: call, result: result, param: "info") as? String {
            V2TIMManager.sharedInstance().setGroupInfo(CustomGroupInfoEntity.init(json: info), succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 修改群消息接收选项
    public func setReceiveMessageOpt(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let opt = CommonUtils.getParam(call: call, result: result, param: "opt") as? Int {
            V2TIMManager.sharedInstance().setReceiveMessageOpt(groupID, opt: V2TIMGroupReceiveMessageOpt.init(rawValue: opt)!, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 初始化群属性，会清空原有的群属性列表
    public func initGroupAttributes(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let attributes = CommonUtils.getParam(call: call, result: result, param: "attributes") as? String {
            V2TIMManager.sharedInstance().initGroupAttributes(groupID, attributes: (JsonUtil.getDictionaryFromJSONString(jsonString: attributes) as! [String: String]), succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 设置群属性
    public func setGroupAttributes(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let attributes = CommonUtils.getParam(call: call, result: result, param: "attributes") as? String {
            V2TIMManager.sharedInstance().setGroupAttributes(groupID, attributes: (JsonUtil.getDictionaryFromJSONString(jsonString: attributes) as! [String: String]), succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 删除群属性
    public func deleteGroupAttributes(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let keys = ((call.arguments as! [String: Any])["keys"]) as? String;
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String {
            V2TIMManager.sharedInstance().deleteGroupAttributes(groupID, keys: keys?.components(separatedBy: ","), succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 获得群属性
    public func getGroupAttributes(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let keys = ((call.arguments as! [String: Any])["keys"]) as? String;
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String {
            V2TIMManager.sharedInstance().getGroupAttributes(groupID, keys: keys?.components(separatedBy: ","), succ: {
                dictionary in
                result(JsonUtil.toJson(dictionary!));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 获得群在线人数
    public func getGroupOnlineMemberCount(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String {
            V2TIMManager.sharedInstance().getGroupOnlineMemberCount(groupID, succ: {
                num in
                result(num);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 获得群成员列表
    public func getGroupMemberList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let filter = CommonUtils.getParam(call: call, result: result, param: "filter") as? Int,
           let nextSeq = CommonUtils.getParam(call: call, result: result, param: "nextSeq") as? UInt64 {
            V2TIMManager.sharedInstance().getGroupMemberList(groupID, filter: V2TIMGroupMemberFilter.init(rawValue: filter)!, nextSeq: nextSeq, succ: {
                nextSeq, infos in
                result(JsonUtil.toJson(CustomGroupMemberInfoResultEntity.init(nextSeq: nextSeq, infos: infos!)));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 获取指定的群成员资料
    public func getGroupMembersInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let memberList = CommonUtils.getParam(call: call, result: result, param: "memberList") as? String {
            V2TIMManager.sharedInstance().getGroupMembersInfo(groupID, memberList: memberList.components(separatedBy: ","), succ: {
                infos in
                var resultData: [[String: Any]] = [];
                for item in infos! {
                    resultData.append(CustomGroupMemberFullInfoEntity.getDict(info: item))
                }
                result(JsonUtil.toJson(resultData));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 获取指定的群成员资料
    public func setGroupMemberInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let info = CommonUtils.getParam(call: call, result: result, param: "info") as? String {
            V2TIMManager.sharedInstance().setGroupMemberInfo(groupID, info: CustomGroupMemberFullInfoEntity.init(json: info), succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 禁言
    public func muteGroupMember(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let userID = CommonUtils.getParam(call: call, result: result, param: "userID") as? String,
           let seconds = CommonUtils.getParam(call: call, result: result, param: "seconds") as? UInt32 {
            V2TIMManager.sharedInstance().muteGroupMember(groupID, member: userID, muteTime: seconds, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 邀请他人进群
    public func inviteUserToGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let userList = CommonUtils.getParam(call: call, result: result, param: "userList") as? String {
            V2TIMManager.sharedInstance().inviteUser(toGroup: groupID, userList: userList.components(separatedBy: ","), succ: {
                infos in
                var resultData: [[String: Any]] = [];
                for item in infos! {
                    resultData.append(CustomGroupMemberOperationResultEntity.getDict(info: item))
                }
                result(JsonUtil.toJson(resultData));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 踢人
    public func kickGroupMember(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let memberList = CommonUtils.getParam(call: call, result: result, param: "memberList") as? String,
           let reason = CommonUtils.getParam(call: call, result: result, param: "reason") as? String {
            V2TIMManager.sharedInstance().kickGroupMember(groupID, memberList: memberList.components(separatedBy: ","), reason: reason, succ: {
                infos in
                var resultData: [[String: Any]] = [];
                for item in infos! {
                    resultData.append(CustomGroupMemberOperationResultEntity.getDict(info: item))
                }
                result(JsonUtil.toJson(resultData));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 切换群成员角色
    public func setGroupMemberRole(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let userID = CommonUtils.getParam(call: call, result: result, param: "userID") as? String,
           let role = CommonUtils.getParam(call: call, result: result, param: "role") as? Int {
            V2TIMManager.sharedInstance().setGroupMemberRole(groupID, member: userID, newRole: V2TIMGroupMemberRole.init(rawValue: role)!, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 转让群主
    public func transferGroupOwner(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let userID = CommonUtils.getParam(call: call, result: result, param: "userID") as? String {
            V2TIMManager.sharedInstance().transferGroupOwner(groupID, member: userID, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 获取加群的申请列表
    public func getGroupApplicationList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        V2TIMManager.sharedInstance().getGroupApplicationList({
            info in
            result(JsonUtil.toJson(CustomGroupApplicationResultEntity.getDict(info: info!)));
        }, fail: TencentImUtils.returnErrorClosures(result: result))
    }

    /// 同意某一条加群申请
    public func acceptGroupApplication(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let application = CommonUtils.getParam(call: call, result: result, param: "application") as? String,
           let reason = CommonUtils.getParam(call: call, result: result, param: "reason") as? String {
            TencentImUtils.getGroupApplicationByFindGroupApplicationEntity(json: application, succ: {
                (application: V2TIMGroupApplication?) -> () in
                V2TIMManager.sharedInstance().accept(application!, reason: reason, succ: {
                    result(nil);
                }, fail: TencentImUtils.returnErrorClosures(result: result))
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 拒绝某一条加群申请
    public func refuseGroupApplication(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let application = CommonUtils.getParam(call: call, result: result, param: "application") as? String,
           let reason = CommonUtils.getParam(call: call, result: result, param: "reason") as? String {
            TencentImUtils.getGroupApplicationByFindGroupApplicationEntity(json: application, succ: {
                (application: V2TIMGroupApplication?) -> () in
                V2TIMManager.sharedInstance().refuse(application!, reason: reason, succ: {
                    result(nil);
                }, fail: TencentImUtils.returnErrorClosures(result: result))
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 标记申请列表为已读
    public func setGroupApplicationRead(call: FlutterMethodCall, result: @escaping FlutterResult) {
        V2TIMManager.sharedInstance().setGroupApplicationRead({
            result(nil);
        }, fail: TencentImUtils.returnErrorClosures(result: result))
    }

    /// 获得会话列表
    public func getConversationList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let nextSeq = CommonUtils.getParam(call: call, result: result, param: "nextSeq") as? UInt64,
           let count = CommonUtils.getParam(call: call, result: result, param: "count") as? Int32 {
            V2TIMManager.sharedInstance().getConversationList(nextSeq, count: count, succ: {
                conversations, nextSeq, finished in
                result(JsonUtil.toJson(CustomConversationResultEntity.init(conversations: conversations!, nextSeq: nextSeq, finished: finished)));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 获得会话
    public func getConversation(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let conversationID = CommonUtils.getParam(call: call, result: result, param: "conversationID") as? String {
            V2TIMManager.sharedInstance().getConversation(conversationID, succ: {
                conversation in
                result(JsonUtil.toJson(CustomConversationEntity.getDict(info: conversation!)));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 删除会话
    public func deleteConversation(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let conversationID = CommonUtils.getParam(call: call, result: result, param: "conversationID") as? String {
            V2TIMManager.sharedInstance().deleteConversation(conversationID, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }


    /// 设置会话草稿
    public func setConversationDraft(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let draftText = ((call.arguments as! [String: Any])["draftText"]) as? String;
        if let conversationID = CommonUtils.getParam(call: call, result: result, param: "conversationID") as? String {
            V2TIMManager.sharedInstance().setConversationDraft(conversationID, draftText: draftText, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 获得用户资料
    public func getUsersInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userIDList = CommonUtils.getParam(call: call, result: result, param: "userIDList") as? String {
            V2TIMManager.sharedInstance().getUsersInfo(userIDList.components(separatedBy: ","), succ: {
                infos in
                var data: [[String: Any]] = [];
                for item in infos! {
                    data.append(CustomUserEntity.getDict(info: item));
                }
                result(JsonUtil.toJson(data));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 修改自己的资料
    public func setSelfInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let info = CommonUtils.getParam(call: call, result: result, param: "info") as? String {
            V2TIMManager.sharedInstance().setSelfInfo(CustomUserEntity.init(json: info), succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 添加用户到黑名单
    public func addToBlackList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userIDList = CommonUtils.getParam(call: call, result: result, param: "userIDList") as? String {
            V2TIMManager.sharedInstance().add(toBlackList: userIDList.components(separatedBy: ","), succ: {
                infos in
                var data: [[String: Any]] = [];
                for item in infos! {
                    data.append(CustomFriendOperationResultEntity.getDict(info: item));
                }
                result(JsonUtil.toJson(data));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 从黑名单中删除
    public func deleteFromBlackList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userIDList = CommonUtils.getParam(call: call, result: result, param: "userIDList") as? String {
            V2TIMManager.sharedInstance().delete(fromBlackList: userIDList.components(separatedBy: ","), succ: {
                infos in
                var data: [[String: Any]] = [];
                for item in infos! {
                    data.append(CustomFriendOperationResultEntity.getDict(info: item));
                }
                result(JsonUtil.toJson(data));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 获得黑名单列表
    public func getBlackList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        V2TIMManager.sharedInstance().getBlackList({
            infos in
            var data: [[String: Any]] = [];
            for item in infos! {
                data.append(CustomFriendInfoEntity.getDict(info: item));
            }
            result(JsonUtil.toJson(data));
        }, fail: TencentImUtils.returnErrorClosures(result: result))
    }

    /// 设置离线推送
    public func setOfflinePushConfig(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let token = CommonUtils.getParam(call: call, result: result, param: "token") as? String,
           let bussid = CommonUtils.getParam(call: call, result: result, param: "bussid") as? Int32 {

            let config = V2TIMAPNSConfig();
            config.token = CommonUtils.dataWithHexString(hex: token);
            config.businessID = bussid;

            V2TIMManager.sharedInstance().setAPNS(config, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 设置未读桌标
    public func setUnreadBadge(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let number = CommonUtils.getParam(call: call, result: result, param: "number") as? UInt32 {
            CustomAPNSListener.number = number;
            result(nil);
        }
    }

    /// 获得好友列表
    public func getFriendList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        V2TIMManager.sharedInstance().getFriendList({
            infos in
            var data: [[String: Any]] = [];
            for item in infos! {
                data.append(CustomFriendInfoEntity.getDict(info: item));
            }
            result(JsonUtil.toJson(data));
        }, fail: TencentImUtils.returnErrorClosures(result: result));
    }

    /// 获得指定好友信息
    public func getFriendsInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userIDList = CommonUtils.getParam(call: call, result: result, param: "userIDList") as? String {
            V2TIMManager.sharedInstance().getFriendsInfo(userIDList.components(separatedBy: ","), succ: {
                infos in
                var data: [[String: Any]] = [];
                for item in infos! {
                    data.append(CustomFriendInfoResultEntity.getDict(info: item));
                }
                result(JsonUtil.toJson(data));
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 设置好友资料
    public func setFriendInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let info = CommonUtils.getParam(call: call, result: result, param: "info") as? String {
            V2TIMManager.sharedInstance().setFriendInfo(CustomFriendInfoEntity.init(json: info), succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 添加好友
    public func addFriend(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let info = CommonUtils.getParam(call: call, result: result, param: "info") as? String {
            V2TIMManager.sharedInstance().addFriend(CustomFriendAddApplicationEntity.init(json: info), succ: {
                info in
                result(JsonUtil.toJson(CustomFriendOperationResultEntity.getDict(info: info!)));
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 删除好友
    public func deleteFromFriendList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userIDList = CommonUtils.getParam(call: call, result: result, param: "userIDList") as? String,
           let deleteType = CommonUtils.getParam(call: call, result: result, param: "deleteType") as? Int {
            V2TIMManager.sharedInstance().delete(fromFriendList: userIDList.components(separatedBy: ","), delete: V2TIMFriendType.init(rawValue: deleteType)!, succ: {
                infos in
                var data: [[String: Any]] = [];
                for item in infos! {
                    data.append(CustomFriendOperationResultEntity.getDict(info: item));
                }
                result(JsonUtil.toJson(data));
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 检查好友关系
    public func checkFriend(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let userID = CommonUtils.getParam(call: call, result: result, param: "userID") as? String,
           let _ = CommonUtils.getParam(call: call, result: result, param: "checkType") as? Int {
            V2TIMManager.sharedInstance().checkFriend(userID, succ: {
                info in
                result(JsonUtil.toJson(CustomFriendCheckResultEntity.getDict(info: info!)));
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 获得好友申请列表
    public func getFriendApplicationList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        V2TIMManager.sharedInstance().getFriendApplicationList({
            info in
            result(JsonUtil.toJson(CustomFriendApplicationResultEntity.getDict(info: info!)));
        }, fail: TencentImUtils.returnErrorClosures(result: result));
    }

    /// 同意建立好友申请关系
    public func acceptFriendApplication(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let application = CommonUtils.getParam(call: call, result: result, param: "application") as? String,
           let responseType = CommonUtils.getParam(call: call, result: result, param: "responseType") as? Int {
            TencentImUtils.getFriendApplicationByFindFriendApplicationEntity(json: application, succ: {
                (v2TIMFriendApplication: V2TIMFriendApplication?) -> () in
                V2TIMManager.sharedInstance().accept(v2TIMFriendApplication!, type: V2TIMFriendAcceptType.init(rawValue: responseType)!, succ: {
                    info in
                    result(JsonUtil.toJson(CustomFriendOperationResultEntity.getDict(info: info!)));
                }, fail: TencentImUtils.returnErrorClosures(result: result));
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 拒绝建立好友申请关系
    public func refuseFriendApplication(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let application = CommonUtils.getParam(call: call, result: result, param: "application") as? String {
            TencentImUtils.getFriendApplicationByFindFriendApplicationEntity(json: application, succ: {
                (v2TIMFriendApplication: V2TIMFriendApplication?) -> () in
                V2TIMManager.sharedInstance().refuse(v2TIMFriendApplication!, succ: {
                    info in
                    result(JsonUtil.toJson(CustomFriendOperationResultEntity.getDict(info: info!)));
                }, fail: TencentImUtils.returnErrorClosures(result: result));
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 删除好友申请
    public func deleteFriendApplication(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let application = CommonUtils.getParam(call: call, result: result, param: "application") as? String {
            TencentImUtils.getFriendApplicationByFindFriendApplicationEntity(json: application, succ: {
                (v2TIMFriendApplication: V2TIMFriendApplication?) -> () in
                V2TIMManager.sharedInstance().delete(v2TIMFriendApplication!, succ: {
                    result(nil);
                }, fail: TencentImUtils.returnErrorClosures(result: result));
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 设置好友申请为已读
    public func setFriendApplicationRead(call: FlutterMethodCall, result: @escaping FlutterResult) {
        V2TIMManager.sharedInstance().setFriendApplicationRead({
            result(nil);
        }, fail: TencentImUtils.returnErrorClosures(result: result));
    }

    /// 新建好友分组
    public func createFriendGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupName = CommonUtils.getParam(call: call, result: result, param: "groupName") as? String,
           let userIDList = CommonUtils.getParam(call: call, result: result, param: "userIDList") as? String {
            V2TIMManager.sharedInstance().createFriendGroup(groupName, userIDList: userIDList.components(separatedBy: ","), succ: {
                infos in
                var data: [[String: Any]] = [];
                for item in infos! {
                    data.append(CustomFriendOperationResultEntity.getDict(info: item));
                }
                result(JsonUtil.toJson(data));
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 获得分组信息
    public func getFriendGroups(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let groupNameList = ((call.arguments as! [String: Any])["groupNameList"]) as? String;
        V2TIMManager.sharedInstance().getFriendGroupList(groupNameList?.components(separatedBy: ","), succ: {
            infos in
            var data: [[String: Any]] = [];
            for item in infos! {
                data.append(CustomFriendGroupEntity.getDict(info: item));
            }
            result(JsonUtil.toJson(data));
        }, fail: TencentImUtils.returnErrorClosures(result: result));
    }

    /// 删除分组
    public func deleteFriendGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupNameList = CommonUtils.getParam(call: call, result: result, param: "groupNameList") as? String {
            V2TIMManager.sharedInstance().deleteFriendGroup(groupNameList.components(separatedBy: ","), succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 修改分组名称
    public func renameFriendGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let oldName = CommonUtils.getParam(call: call, result: result, param: "oldName") as? String,
           let newName = CommonUtils.getParam(call: call, result: result, param: "newName") as? String {
            V2TIMManager.sharedInstance().renameFriendGroup(oldName, newName: newName, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 添加好友到分组
    public func addFriendsToFriendGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupName = CommonUtils.getParam(call: call, result: result, param: "groupName") as? String,
           let userIDList = CommonUtils.getParam(call: call, result: result, param: "userIDList") as? String {
            V2TIMManager.sharedInstance().addFriends(toFriendGroup: groupName, userIDList: userIDList.components(separatedBy: ","), succ: {
                infos in
                var data: [[String: Any]] = [];
                for item in infos! {
                    data.append(CustomFriendOperationResultEntity.getDict(info: item));
                }
                result(JsonUtil.toJson(data));
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /// 从分组中删除好友
    public func deleteFriendsFromFriendGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let groupName = CommonUtils.getParam(call: call, result: result, param: "groupName") as? String,
           let userIDList = CommonUtils.getParam(call: call, result: result, param: "userIDList") as? String {
            V2TIMManager.sharedInstance().deleteFriends(fromFriendGroup: groupName, userIDList: userIDList.components(separatedBy: ","), succ: {
                infos in
                var data: [[String: Any]] = [];
                for item in infos! {
                    data.append(CustomFriendOperationResultEntity.getDict(info: item));
                }
                result(JsonUtil.toJson(data));
            }, fail: TencentImUtils.returnErrorClosures(result: result));
        }
    }

    /**
     * 调用监听器
     *
     * @param type   类型
     * @param params 参数
     */
    public static func invokeListener(type: ListenerType, params: Any?) {
        var resultParams: [String: Any] = [:];
        resultParams["type"] = type;
        if let p = params {
            resultParams["params"] = p;
        }
        SwiftTencentImPlugin.channel!.invokeMethod("onListener", arguments: JsonUtil.toJson(resultParams));
    }
}
