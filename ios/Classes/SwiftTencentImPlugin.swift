import Flutter
import UIKit
import ImSDK
import HandyJSON

public class SwiftTencentImPlugin: NSObject, FlutterPlugin {
    public static var channel: FlutterMethodChannel?;

    /// 监听器回调的方法名
    private static let LISTENER_FUNC_NAME = "onListener";


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
        case "revokeMessage":
            self.revokeMessage(call: call, result: result);
            break;
        case "getC2CHistoryMessageList":
            self.getC2CHistoryMessageList(call: call, result: result);
            break;
        case "getGroupHistoryMessageList":
            self.getGroupHistoryMessageList(call: call, result: result);
            break;
//        case "getConversationList":
//            getConversationList(call: call, result: result)
//            break
//        case "getConversation":
//            getConversation(call: call, result: result)
//            break
//        case "getGroupInfo":
//            self.getGroupInfo(call: call, result: result);
//            break;
//        case "getUserInfo":
//            self.getUserInfo(call: call, result: result);
//            break;
//        case "getMessages":
//            self.getMessages(call: call, result: result);
//            break;
//        case "getLocalMessages":
//            self.getLocalMessages(call: call, result: result);
//            break;
//        case "setRead":
//            self.setRead(call: call, result: result);
//            break;
//        case "saveMessage":
//            self.saveMessage(call: call, result: result);
//            break;
//        case "getFriendList":
//            self.getFriendList(call: call, result: result);
//            break;
//        case "getGroupList":
//            self.getGroupList(call: call, result: result);
//            break;
//        case "addFriend":
//            self.addFriend(call: call, result: result);
//            break;
//        case "checkSingleFriends":
//            self.checkSingleFriends(call: call, result: result);
//            break;
//        case "getPendencyList":
//            self.getPendencyList(call: call, result: result);
//            break;
//        case "pendencyReport":
//            self.pendencyReport(call: call, result: result);
//            break;
//        case "deletePendency":
//            self.deletePendency(call: call, result: result);
//            break;
//        case "examinePendency":
//            self.examinePendency(call: call, result: result);
//            break;
//        case "deleteConversation":
//            self.deleteConversation(call: call, result: result);
//            break;
//        case "deleteLocalMessage":
//            self.deleteLocalMessage(call: call, result: result);
//            break;
//        case "createGroup":
//            self.createGroup(call: call, result: result);
//            break;
//        case "inviteGroupMember":
//            self.inviteGroupMember(call: call, result: result);
//            break;
//        case "applyJoinGroup":
//            self.applyJoinGroup(call: call, result: result);
//            break;
//        case "quitGroup":
//            self.quitGroup(call: call, result: result);
//            break;
//        case "deleteGroupMember":
//            self.deleteGroupMember(call: call, result: result);
//            break;
//        case "getGroupMembers":
//            self.getGroupMembers(call: call, result: result);
//            break;
//        case "deleteGroup":
//            self.deleteGroup(call: call, result: result);
//            break;
//        case "modifyGroupOwner":
//            self.modifyGroupOwner(call: call, result: result);
//            break;
//        case "modifyGroupInfo":
//            self.modifyGroupInfo(call: call, result: result);
//            break;
//        case "modifyMemberInfo":
//            self.modifyMemberInfo(call: call, result: result);
//            break;
//        case "getGroupPendencyList":
//            self.getGroupPendencyList(call: call, result: result);
//            break;
//        case "reportGroupPendency":
//            self.reportGroupPendency(call: call, result: result);
//            break;
//        case "groupPendencyAccept":
//            self.groupPendencyAccept(call: call, result: result);
//            break;
//        case "groupPendencyRefuse":
//            self.groupPendencyRefuse(call: call, result: result);
//            break;
//        case "getSelfProfile":
//            self.getSelfProfile(call: call, result: result);
//            break;
//        case "modifySelfProfile":
//            self.modifySelfProfile(call: call, result: result);
//            break;
//        case "modifyFriend":
//            self.modifyFriend(call: call, result: result);
//            break;
//        case "deleteFriends":
//            self.deleteFriends(call: call, result: result);
//            break;
//        case "addBlackList":
//            self.addBlackList(call: call, result: result);
//            break;
//        case "deleteBlackList":
//            self.deleteBlackList(call: call, result: result);
//            break;
//        case "getBlackList":
//            self.getBlackList(call: call, result: result);
//            break;
//        case "createFriendGroup":
//            self.createFriendGroup(call: call, result: result);
//            break;
//        case "deleteFriendGroup":
//            self.deleteFriendGroup(call: call, result: result);
//            break;
//        case "addFriendsToFriendGroup":
//            self.addFriendsToFriendGroup(call: call, result: result);
//            break;
//        case "deleteFriendsFromFriendGroup":
//            self.deleteFriendsFromFriendGroup(call: call, result: result);
//            break;
//        case "renameFriendGroup":
//            self.renameFriendGroup(call: call, result: result);
//            break;
//        case "getFriendGroups":
//            self.getFriendGroups(call: call, result: result);
//            break;
//        case "revokeMessage":
//            self.revokeMessage(call: call, result: result);
//            break;
//        case "removeMessage":
//            self.removeMessage(call: call, result: result);
//            break;
//        case "setMessageCustomInt":
//            self.setMessageCustomInt(call: call, result: result);
//            break;
//        case "setMessageCustomStr":
//            self.setMessageCustomStr(call: call, result: result);
//            break;
//        case "downloadVideoImage":
//            self.downloadVideoImage(call: call, result: result);
//            break;
//        case "downloadVideo":
//            self.downloadVideo(call: call, result: result);
//            break;
//        case "downloadSound":
//            self.downloadSound(call: call, result: result);
//            break;
//        case "findMessage":
//            self.findMessage(call: call, result: result);
//            break;
//        case "setOfflinePushSettings":
//            self.setOfflinePushSettings(call: call, result: result);
//            break;
//        case "setOfflinePushToken":
//            self.setOfflinePushToken(call: call, result: result);
//            break;
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
            V2TIMManager.sharedInstance().initSDK((appid as NSString).intValue, config: sdkConfig, listener: CustomSDKListener())

            // 绑定消息监听
            V2TIMManager.sharedInstance().add(CustomAdvancedMsgListener())

            // 绑定会话监听
            V2TIMManager.sharedInstance().setConversationListener(CustomConversationListener())

            // 绑定群监听
            V2TIMManager.sharedInstance().setGroupListener(CustomGroupListener())

            // 绑定关系链监听
            V2TIMManager.sharedInstance().setFriendListener(CustomFriendshipListener())

            // 绑定信令监听
            V2TIMManager.sharedInstance().addSignalingListener(listener: CustomSignalingListener())

            result(nil);
        }
    }


    /// 反初始化
    public func unInitSDK(call: FlutterMethodCall, result: @escaping FlutterResult) {
        V2TIMManager.sharedInstance().unInitSDK();
        result(nil);
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
            result(JsonUtil.toJson(V2TIMManager.sharedInstance().getSignallingInfo(FindMessageEntity.init(json: messageStr).getMessage())));
        }
    }

    /// 添加邀请信令（可以用于群离线推送消息触发的邀请信令）
    public func addInvitedSignaling(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let info = CommonUtils.getParam(call: call, result: result, param: "info") as? String {
            let dict = JsonUtil.getDictionaryFromJSONString(jsonString: info);
            let signalingInfo = V2TIMSignalingInfo();
            if dict["inviteID"] != nil {
                signalingInfo.inviteID = (dict["inviteID"] as! String);
            }
            if dict["groupID"] != nil {
                signalingInfo.groupID = (dict["groupID"] as! String);
            }
            if dict["inviter"] != nil {
                signalingInfo.groupID = (dict["inviter"] as! String);
            }
            if dict["inviteeList"] != nil {
                signalingInfo.inviteeList = (dict["inviteeList"] as! NSMutableArray);
            }
            if dict["data"] != nil {
                signalingInfo.data = (dict["data"] as! String);
            }
            if dict["timeout"] != nil {
                signalingInfo.timeout = (dict["timeout"] as! UInt32);
            }
            if dict["actionType"] != nil {
                signalingInfo.actionType = SignalingActionType.init(rawValue: (dict["actionType"] as! Int))!;
            }
            V2TIMManager.sharedInstance().addInvitedSignaling(signalingInfo, succ: {
                () -> Void in
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 发送消息
    private func sendMessage(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let receiver = ((call.arguments as! [String: Any])["receiver"]) as? String;
        let groupID = ((call.arguments as! [String: Any])["groupID"]) as? String;
        let localCustomInt = ((call.arguments as! [String: Any])["localCustomInt"]) as? Int32;
        let localCustomStr = ((call.arguments as! [String: Any])["localCustomStr"]) as? String;
        let offlinePushInfo = ((call.arguments as! [String: Any])["offlinePushInfo"]) as? String;
        if let nodeStr = CommonUtils.getParam(call: call, result: result, param: "node") as? String,
           let ol = CommonUtils.getParam(call: call, result: result, param: "ol") as? Bool,
           let priority = CommonUtils.getParam(call: call, result: result, param: "priority") as? Int {
            // 将节点信息解析
            let node = JsonUtil.getDictionaryFromJSONString(jsonString: nodeStr);

            // 获得发送消息体
            let message: V2TIMMessage = MessageNodeType.getMessageNodeTypeByV2TIMConstant(constant: node["nodeType"] as! Int).messageNodeInterface().getV2TIMMessage(params: node);
            if localCustomInt != nil {
                message.localCustomInt = localCustomInt!;
            }
            if localCustomStr != nil {
                message.localCustomData = localCustomStr!.data(using: .utf8);
            }


            // 发送消息
            V2TIMManager.sharedInstance().send(message, receiver: receiver, groupID: groupID, priority: V2TIMMessagePriority.init(rawValue: priority)!, onlineUserOnly: ol, offlinePushInfo: CustomOfflinePushInfoEntity.init(jsonStr: offlinePushInfo), progress:
            { int32 in

            }, succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }


    /// 撤回消息
    public func revokeMessage(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let messageStr = CommonUtils.getParam(call: call, result: result, param: "message") as? String {
            V2TIMManager.sharedInstance().revokeMessage(FindMessageEntity.init(json: messageStr).getMessage(), succ: {
                result(nil);
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 获得单聊历史记录
    public func getC2CHistoryMessageList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let lastMsg = ((call.arguments as! [String: Any])["lastMsg"]) as? String;
        if let userID = CommonUtils.getParam(call: call, result: result, param: "userID") as? String,
           let count = CommonUtils.getParam(call: call, result: result, param: "count") as? Int32 {
            V2TIMManager.sharedInstance().getC2CHistoryMessageList(userID, count: count, lastMsg: lastMsg == nil ? nil : FindMessageEntity.init(json: lastMsg!).getMessage(), succ: {
                messages in
                var resultData: [MessageEntity] = [];
                for item in messages! {
                    resultData.append(MessageEntity.init(message: item));
                }
                result(JsonUtil.toJson(resultData));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }

    /// 获得群聊历史记录
    public func getGroupHistoryMessageList(call: FlutterMethodCall, result: @escaping FlutterResult) {
        let lastMsg = ((call.arguments as! [String: Any])["lastMsg"]) as? String;
        if let groupID = CommonUtils.getParam(call: call, result: result, param: "groupID") as? String,
           let count = CommonUtils.getParam(call: call, result: result, param: "count") as? Int32 {
            V2TIMManager.sharedInstance().getGroupHistoryMessageList(groupID, count: count, lastMsg: lastMsg == nil ? nil : FindMessageEntity.init(json: lastMsg!).getMessage(), succ: {
                messages in
                var resultData: [MessageEntity] = [];
                for item in messages! {
                    resultData.append(MessageEntity.init(message: item));
                }
                result(JsonUtil.toJson(resultData));
            }, fail: TencentImUtils.returnErrorClosures(result: result))
        }
    }


//    /**
//     * 获得当前登录用户会话列表
//     */
//    public func getConversationList(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        TencentImUtils.getConversationInfo(conversations: (V2TIMManager.sharedInstance()?.getConversationList())!, onSuccess: {
//            (array) -> Void in
//            result(JsonUtil.toJson(array));
//        }, onFail: TencentImUtils.returnErrorClosures(result: result));
//    }
//
//    /**
//     * 根据ID获得会话
//     */
//    public func getConversation(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let sessionId = CommonUtils.getParam(call: call, result: result, param: "sessionId") as? String,
//           let sessionTypeStr = CommonUtils.getParam(call: call, result: result, param: "sessionType") as? String {
//            if let session = TencentImUtils.getSession(sessionId: sessionId, sessionTypeStr: sessionTypeStr, result: result) {
//                TencentImUtils.getConversationInfo(conversations: ([session]), onSuccess: {
//                    (array) -> Void in
//                    if array.count >= 1 {
//                        result(JsonUtil.toJson(array[0]));
//                    } else {
//                        result(nil);
//                    }
//                }, onFail: TencentImUtils.returnErrorClosures(result: result));
//            }
//        }
//    }
//
//    /**
//     * 获得群信息
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func getGroupInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let id = CommonUtils.getParam(call: call, result: result, param: "id") {
//            TIMGroupManager.sharedInstance()?.getGroupInfo([id], succ: {
//                (array) -> Void in
//                if array!.count >= 1 {
//                    result(JsonUtil.toJson(GroupInfoEntity(groupInfo: array![0] as! TIMGroupInfoResult)));
//                } else {
//                    result(nil);
//                }
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 获得用户信息
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func getUserInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let id = CommonUtils.getParam(call: call, result: result, param: "id") as? String,
//           let forceUpdate = CommonUtils.getParam(call: call, result: result, param: "forceUpdate") as? Bool {
//            TIMFriendshipManager.sharedInstance()?.getUsersProfile([id], forceUpdate: forceUpdate, succ: {
//                (array) -> Void in
//                if array!.count >= 1 {
//                    result(JsonUtil.toJson(UserInfoEntity(userProfile: array![0])));
//                } else {
//                    result(nil);
//                }
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 设置会话消息为已读
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func setRead(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let sessionId = CommonUtils.getParam(call: call, result: result, param: "sessionId") as? String,
//           let sessionTypeStr = CommonUtils.getParam(call: call, result: result, param: "sessionType") as? String {
//            if let session = TencentImUtils.getSession(sessionId: sessionId, sessionTypeStr: sessionTypeStr, result: result) {
//                session.setRead(nil, succ: {
//                    result(nil);
//                }, fail: TencentImUtils.returnErrorClosures(result: result))
//            }
//        }
//    }
//
//
//    /**
//     * 获得消息列表
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func getMessages(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        self.getMessages(call: call, result: result, local: false);
//    }
//
//    /**
//     * 获得本地消息列表
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func getLocalMessages(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        self.getMessages(call: call, result: result, local: true);
//    }
//
//    /**
//     * 获得消息列表
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     * @param local      是否是获取本地消息
//     */
//    private func getMessages(call: FlutterMethodCall, result: @escaping FlutterResult, local: Bool) {
//        if let sessionId = CommonUtils.getParam(call: call, result: result, param: "sessionId") as? String,
//           let sessionTypeStr = CommonUtils.getParam(call: call, result: result, param: "sessionType") as? String,
//           let number = CommonUtils.getParam(call: call, result: result, param: "number") as? Int32 {
//            if let session = TencentImUtils.getSession(sessionId: sessionId, sessionTypeStr: sessionTypeStr, result: result) {
//                TencentImUtils.getTimMessage(call: call, result: result, name: "lastMessage", onCallback: {
//                    (message) -> Void in
//                    // 成功回调
//                    let successCallback = {
//                        (array: Any) -> Void in
//                        TencentImUtils.getMessageInfo(timMessages: array as! [TIMMessage], onSuccess: {
//                            (array) -> Void in
//                            result(JsonUtil.toJson(array));
//                        }, onFail: TencentImUtils.returnErrorClosures(result: result));
//                    };
//                    // 获取本地消息记录或云端消息记录
//                    if local {
//                        session.getLocalMessage(number, last: message, succ: successCallback, fail: TencentImUtils.returnErrorClosures(result: result))
//                    } else {
//                        session.getMessage(number, last: message, succ: successCallback, fail: TencentImUtils.returnErrorClosures(result: result))
//                    }
//                });
//            }
//        }
//    }
//
//    /**
//     * 发送消息
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func saveMessage(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let sessionId = CommonUtils.getParam(call: call, result: result, param: "sessionId") as? String,
//           let sessionType = CommonUtils.getParam(call: call, result: result, param: "sessionType") as? String,
//           let nodeStr = CommonUtils.getParam(call: call, result: result, param: "node") as? String,
//           let sender = CommonUtils.getParam(call: call, result: result, param: "sender") as? String,
//           let isReaded = CommonUtils.getParam(call: call, result: result, param: "isReaded") as? Bool {
//            // 将节点信息解析
//            let node = JsonUtil.getDictionaryFromJSONString(jsonString: nodeStr);
//
//            // 通过多态发送消息
//            let message = MessageNodeType.valueOf(name: node["nodeType"] as! String)?.messageNodeInterface().save(conversation: TencentImUtils.getSession(sessionId: sessionId, sessionTypeStr: sessionType, result: result)!, params: node, sender: sender, isReaded: isReaded);
//
//            TencentImUtils.getMessageInfo(timMessages: [message!], onSuccess: {
//                (array) -> Void in
//                result(JsonUtil.toJson(array[0]));
//            }, onFail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 获得好友列表
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func getFriendList(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        TIMFriendshipManager.sharedInstance()?.getFriendList({
//            (array) -> Void in
//            var resultData: [FriendEntity] = []
//            for item in array! {
//                resultData.append(FriendEntity(friend: item));
//            }
//            result(JsonUtil.toJson(resultData));
//        }, fail: TencentImUtils.returnErrorClosures(result: result));
//    }
//
//    /**
//     * 获得群组列表
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func getGroupList(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        TIMGroupManager.sharedInstance()?.getGroupList({
//            (array) -> Void in
//            var ids: [String] = [];
//            for item in array! {
//                ids.append((item as! TIMGroupInfo).group)
//            }
//
//            if (ids.count == 0) {
//                result(JsonUtil.toJson([]));
//                return;
//            }
//
//            // 获得群资料
//            TIMGroupManager.sharedInstance()?.getGroupInfo(ids, succ: {
//                (array) -> Void in
//                var resultData: [GroupInfoEntity] = []
//                for item in array! {
//                    resultData.append(GroupInfoEntity(groupInfo: item as! TIMGroupInfoResult));
//                }
//                result(JsonUtil.toJson(resultData));
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }, fail: TencentImUtils.returnErrorClosures(result: result));
//    }
//
//    /**
//     * 添加好友
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func addFriend(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        let remark = ((call.arguments as! [String: Any])["remark"]) as? String;
//        let addWording = ((call.arguments as! [String: Any])["addWording"]) as? String;
//        let addSource = ((call.arguments as! [String: Any])["addSource"]) as? String;
//        let friendGroup = ((call.arguments as! [String: Any])["friendGroup"]) as? String;
//        if let id = CommonUtils.getParam(call: call, result: result, param: "id") as? String,
//           let addType = CommonUtils.getParam(call: call, result: result, param: "addType") as? Int {
//            let request = TIMFriendRequest();
//            request.identifier = id;
//            request.addType = TIMFriendAddType(rawValue: addType)!;
//            if remark != nil {
//                request.remark = remark!;
//            }
//            if addWording != nil {
//                request.addWording = addWording!;
//            }
//            if addSource != nil {
//                request.addSource = addSource!;
//            }
//            if friendGroup != nil {
//                request.group = friendGroup;
//            }
//
//            TIMFriendshipManager.sharedInstance()?.addFriend(request, succ: {
//                (data) -> Void in
//                result(JsonUtil.toJson(FriendResultEntity(result: data!)));
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 检测单个好友关系
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func checkSingleFriends(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        let type = ((call.arguments as! [String: Any])["type"]) as? Int;
//        if let id = CommonUtils.getParam(call: call, result: result, param: "id") as? String {
//            let checkInfo = TIMFriendCheckInfo();
//            if type != nil {
//                checkInfo.checkType = TIMFriendCheckType(rawValue: type!)!;
//            }
//            checkInfo.users = [id];
//
//            TIMFriendshipManager.sharedInstance()?.checkFriends(checkInfo, succ: {
//                (array) -> Void in
//                result(JsonUtil.toJson(FriendCheckResultEntity(result: (array!)[0])));
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 获得未决好友列表(申请中)
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func getPendencyList(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        let seq = ((call.arguments as! [String: Any])["seq"]) as? UInt64;
//        let timestamp = ((call.arguments as! [String: Any])["timestamp"]) as? UInt64;
//        let numPerPage = ((call.arguments as! [String: Any])["numPerPage"]) as? UInt64;
//        if let type = CommonUtils.getParam(call: call, result: result, param: "type") as? Int {
//            let request = TIMFriendPendencyRequest();
//            request.type = TIMPendencyType(rawValue: type)!;
//            if seq != nil {
//                request.seq = seq!;
//            }
//            if timestamp != nil {
//                request.timestamp = timestamp!;
//            }
//            if numPerPage != nil {
//                request.numPerPage = numPerPage!;
//            }
//
//            TIMFriendshipManager.sharedInstance()?.getPendencyList(request, succ: {
//                (data) -> Void in
//                if data?.pendencies.count == 0 {
//                    result("{}");
//                    return;
//                }
//
//                // 返回结果
//                var resultData = [PendencyEntity]();
//
//                // 用户ID对应用户对象
//                var map: [String: PendencyEntity] = [:];
//
//                // 循环获得的列表，进行对象封装
//                for item in data!.pendencies {
//                    map[item.identifier] = PendencyEntity(item: item);
//                }
//
//                // 获得用户信息
//                TIMFriendshipManager.sharedInstance()?.getUsersProfile(Array(map.keys), forceUpdate: true, succ: {
//                    (array) -> Void in
//
//                    // 填充用户对象
//                    for item in array! {
//                        if let data = map[item.identifier] {
//                            data.userProfile = UserInfoEntity(userProfile: item);
//                            resultData.append(data);
//                        }
//                    }
//
//                    // 返回结果
//                    result(JsonUtil.toJson(PendencyPageEntity(res: data!, items: resultData)));
//                }, fail: TencentImUtils.returnErrorClosures(result: result));
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 未决已读上报
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func pendencyReport(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let timestamp = CommonUtils.getParam(call: call, result: result, param: "timestamp") as? UInt64 {
//            TIMFriendshipManager.sharedInstance()?.pendencyReport(timestamp, succ: {
//                result(nil);
//            }, fail: TencentImUtils.returnErrorClosures(result: result))
//        }
//    }
//
//    /**
//     * 未决删除
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func deletePendency(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let type = CommonUtils.getParam(call: call, result: result, param: "type") as? Int,
//           let id = CommonUtils.getParam(call: call, result: result, param: "id") as? String {
//            TIMFriendshipManager.sharedInstance()?.delete(TIMPendencyType(rawValue: type)!, users: [id], succ: {
//                result(nil);
//            }, fail: TencentImUtils.returnErrorClosures(result: result))
//        }
//    }
//
//    /**
//     * 未决审核
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func examinePendency(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        let remark = ((call.arguments as! [String: Any])["remark"]) as? String;
//        if let type = CommonUtils.getParam(call: call, result: result, param: "type") as? Int,
//           let id = CommonUtils.getParam(call: call, result: result, param: "id") as? String {
//            let response = TIMFriendResponse();
//            if remark != nil {
//                response.remark = remark!;
//            }
//            response.responseType = TIMFriendResponseType(rawValue: type)!;
//            response.identifier = id;
//
//            TIMFriendshipManager.sharedInstance()?.do(response, succ: {
//                (data) -> Void in
//                result(nil);
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 删除会话
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func deleteConversation(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let sessionId = CommonUtils.getParam(call: call, result: result, param: "sessionId") as? String,
//           let sessionTypeStr = CommonUtils.getParam(call: call, result: result, param: "sessionType") as? String,
//           let removeCache = CommonUtils.getParam(call: call, result: result, param: "removeCache") as? Bool {
//
////            if removeCache {
////                result(V2TIMManager.sharedInstance()?.deleteConversationAndMessages(TIMConversationType(rawValue: SessionType.getEnumByName(name: sessionTypeStr)!.rawValue)!, receiver: sessionId));
////            } else {
////                result(V2TIMManager.sharedInstance()?.delete(TIMConversationType(rawValue: SessionType.getEnumByName(name: sessionTypeStr)!.rawValue)!, receiver: sessionId));
////            }
//        }
//    }
//
//    /**
//     * 删除会话内的本地聊天记录
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func deleteLocalMessage(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let sessionId = CommonUtils.getParam(call: call, result: result, param: "sessionId") as? String,
//           let sessionTypeStr = CommonUtils.getParam(call: call, result: result, param: "sessionType") as? String {
////            result(V2TIMManager.sharedInstance()?.deleteConversationAndMessages(TIMConversationType(rawValue: SessionType.getEnumByName(name: sessionTypeStr)!.rawValue)!, receiver: sessionId));
//        }
//    }
//
//    /**
//     * 创建群组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func createGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        let groupId = ((call.arguments as! [String: Any])["groupId"]) as? String;
//        let notification = ((call.arguments as! [String: Any])["notification"]) as? String;
//        let introduction = ((call.arguments as! [String: Any])["introduction"]) as? String;
//        let faceUrl = ((call.arguments as! [String: Any])["faceUrl"]) as? String;
//        let addOption = ((call.arguments as! [String: Any])["addOption"]) as? String;
//        let maxMemberNum = ((call.arguments as! [String: Any])["maxMemberNum"]) as? UInt32;
//        let members = ((call.arguments as! [String: Any])["members"]) as? String;
//        let customInfo = ((call.arguments as! [String: Any])["customInfo"]) as? String;
//        if let type = CommonUtils.getParam(call: call, result: result, param: "type") as? String,
//           let name = CommonUtils.getParam(call: call, result: result, param: "name") as? String {
//            // 封装群对象
//            let groupInfo = TIMCreateGroupInfo();
//            if groupId != nil {
//                groupInfo.group = groupId!;
//            }
//            if notification != nil {
//                groupInfo.notification = notification!;
//            }
//            if introduction != nil {
//                groupInfo.introduction = introduction!;
//            }
//            if faceUrl != nil {
//                groupInfo.faceURL = faceUrl!;
//            }
//            if addOption != nil {
//                groupInfo.addOpt = TIMGroupAddOpt(rawValue: GroupAddOptType.getEnumByName(name: addOption!)!.rawValue)!;
//            }
//            if maxMemberNum != nil {
//                groupInfo.maxMemberNum = maxMemberNum!;
//            }
//            if members != nil {
//                var memberInfo: [TIMCreateGroupMemberInfo] = [];
//                if let ms = [GroupMemberEntity].deserialize(from: members) {
//                    for item in ms {
//                        memberInfo.append(item!.toTIMCreateGroupMemberInfo());
//                    }
//                }
//                groupInfo.membersInfo = memberInfo;
//            }
//            groupInfo.groupType = type;
//            groupInfo.groupName = name;
//
//            if customInfo != nil {
//                let ci = JsonUtil.getDictionaryFromJSONString(jsonString: customInfo!);
//                var customInfoData: [String: Data] = [:];
//                for (key, value) in ci {
//                    customInfoData[key] = "\(value)".data(using: String.Encoding.utf8);
//                }
//                groupInfo.customInfo = customInfoData;
//            }
//
//            // 创建群
//            TIMGroupManager.sharedInstance()?.createGroup(groupInfo, succ: {
//                (id) -> Void in
//                result(id);
//            }, fail: TencentImUtils.returnErrorClosures(result: result))
//        }
//    }
//
//    /**
//     * 邀请加入群组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func inviteGroupMember(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let groupId = CommonUtils.getParam(call: call, result: result, param: "groupId") as? String,
//           let ids = CommonUtils.getParam(call: call, result: result, param: "ids") as? String {
//            TIMGroupManager.sharedInstance()?.inviteGroupMember(groupId, members: ids.components(separatedBy: ","), succ: {
//                (array) -> Void in
//                var resultData: [GroupMemberResult] = [];
//                for item in array! {
//                    resultData.append(GroupMemberResult(result: item as! TIMGroupMemberResult));
//                }
//                result(JsonUtil.toJson(resultData));
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 申请加入群组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func applyJoinGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let groupId = CommonUtils.getParam(call: call, result: result, param: "groupId") as? String,
//           let reason = CommonUtils.getParam(call: call, result: result, param: "reason") as? String {
//            TIMGroupManager.sharedInstance()?.joinGroup(groupId, msg: reason, succ: {
//                result(nil);
//            }, fail: TencentImUtils.returnErrorClosures(result: result))
//        }
//    }
//
//    /**
//     * 退出群组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func quitGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let groupId = CommonUtils.getParam(call: call, result: result, param: "groupId") as? String {
//            TIMGroupManager.sharedInstance()?.quitGroup(groupId, succ: {
//                result(nil);
//            }, fail: TencentImUtils.returnErrorClosures(result: result))
//        }
//    }
//
//    /**
//     * 删除群组成员
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func deleteGroupMember(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let groupId = CommonUtils.getParam(call: call, result: result, param: "groupId") as? String,
//           let reason = CommonUtils.getParam(call: call, result: result, param: "reason") as? String,
//           let ids = CommonUtils.getParam(call: call, result: result, param: "ids") as? String {
//            TIMGroupManager.sharedInstance()?.deleteGroupMember(withReason: groupId, reason: reason, members: ids.components(separatedBy: ","), succ: {
//                (array) -> Void in
//                var resultData: [GroupMemberResult] = [];
//                for item in array! {
//                    resultData.append(GroupMemberResult(result: item as! TIMGroupMemberResult));
//                }
//                result(JsonUtil.toJson(resultData));
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 获取群成员列表
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func getGroupMembers(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let groupId = CommonUtils.getParam(call: call, result: result, param: "groupId") as? String {
//            TIMGroupManager.sharedInstance()?.getGroupMembers(groupId, succ: {
//                (array) -> Void in
//
//                var userInfo: [String: GroupMemberEntity] = [:];
//                for item in array! {
//                    let member = item as! TIMGroupMemberInfo;
//                    let item = GroupMemberEntity(info: member);
//                    userInfo[member.member] = item;
//                }
//
//                // 获得用户信息
//                TIMFriendshipManager.sharedInstance()?.getUsersProfile(Array(userInfo.keys), forceUpdate: true, succ: {
//                    (array) -> Void in
//
//                    var resultData: [GroupMemberEntity] = [];
//
//                    // 填充用户对象
//                    for item in array! {
//                        if let data = userInfo[item.identifier] {
//                            data.userProfile = UserInfoEntity(userProfile: item);
//                            resultData.append(data);
//                        }
//                    }
//
//                    // 返回结果
//                    result(JsonUtil.toJson(resultData));
//                }, fail: TencentImUtils.returnErrorClosures(result: result));
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 解散群组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func deleteGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let groupId = CommonUtils.getParam(call: call, result: result, param: "groupId") as? String {
//            TIMGroupManager.sharedInstance()?.deleteGroup(groupId, succ: {
//                result(nil);
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 转让群组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func modifyGroupOwner(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let groupId = CommonUtils.getParam(call: call, result: result, param: "groupId") as? String,
//           let identifier = CommonUtils.getParam(call: call, result: result, param: "identifier") as? String {
//            TIMGroupManager.sharedInstance()?.modifyGroupOwner(groupId, user: identifier, succ: {
//                result(nil);
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 修改群资料
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func modifyGroupInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        let notification = ((call.arguments as! [String: Any])["notification"]) as? String;
//        let introduction = ((call.arguments as! [String: Any])["introduction"]) as? String;
//        let faceUrl = ((call.arguments as! [String: Any])["faceUrl"]) as? String;
//        let addOption = ((call.arguments as! [String: Any])["addOption"]) as? String;
//        let groupName = ((call.arguments as! [String: Any])["groupName"]) as? String;
//        let visable = ((call.arguments as! [String: Any])["visable"]) as? Bool;
//        let silenceAll = ((call.arguments as! [String: Any])["silenceAll"]) as? Bool;
//        let customInfo = ((call.arguments as! [String: Any])["customInfo"]) as? String;
//        if let groupId = CommonUtils.getParam(call: call, result: result, param: "groupId") as? String {
//            if silenceAll != nil {
//                TIMGroupManager.sharedInstance()?.modifyGroupAllShutup(groupId, shutup: silenceAll!, succ: {
//                    result(nil);
//                }, fail: TencentImUtils.returnErrorClosures(result: result));
//            }
//
//            if visable != nil {
//                TIMGroupManager.sharedInstance()?.modifyGroupSearchable(groupId, searchable: visable!, succ: {
//                    result(nil);
//                }, fail: TencentImUtils.returnErrorClosures(result: result))
//            }
//
//            if groupName != nil {
//                TIMGroupManager.sharedInstance()?.modifyGroupName(groupId, groupName: groupName!, succ: {
//                    result(nil);
//                }, fail: TencentImUtils.returnErrorClosures(result: result));
//            }
//
//            if addOption != nil {
//                TIMGroupManager.sharedInstance()?.modifyGroupAddOpt(groupId, opt: TIMGroupAddOpt(rawValue: GroupAddOptType.getEnumByName(name: addOption!)!.hashValue)!, succ: {
//                    result(nil);
//                }, fail: TencentImUtils.returnErrorClosures(result: result));
//            }
//
//            if faceUrl != nil {
//                TIMGroupManager.sharedInstance()?.modifyGroupFaceUrl(groupId, url: faceUrl!, succ: {
//                    result(nil);
//                }, fail: TencentImUtils.returnErrorClosures(result: result));
//            }
//
//            if introduction != nil {
//                TIMGroupManager.sharedInstance()?.modifyGroupIntroduction(groupId, introduction: introduction!, succ: {
//                    result(nil);
//                }, fail: TencentImUtils.returnErrorClosures(result: result));
//            }
//
//            if notification != nil {
//                TIMGroupManager.sharedInstance()?.modifyGroupNotification(groupId, notification: notification!, succ: {
//                    result(nil);
//                }, fail: TencentImUtils.returnErrorClosures(result: result));
//            }
//
//            if customInfo != nil {
//                let ci = JsonUtil.getDictionaryFromJSONString(jsonString: customInfo!);
//                var customInfoData: [String: Data] = [:];
//                for (key, value) in ci {
//                    customInfoData[key] = "\(value)".data(using: String.Encoding.utf8);
//                }
//                TIMGroupManager.sharedInstance()?.modifyGroupCustomInfo(groupId, customInfo: customInfoData, succ: {
//                    result(nil);
//                }, fail: TencentImUtils.returnErrorClosures(result: result));
//            }
//        }
//    }
//
//    /**
//     * 修改群成员资料
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func modifyMemberInfo(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        let nameCard = ((call.arguments as! [String: Any])["nameCard"]) as? String;
//        let silence = ((call.arguments as! [String: Any])["silence"]) as? UInt32;
//        let role = ((call.arguments as! [String: Any])["role"]) as? Int;
//        let customInfo = ((call.arguments as! [String: Any])["customInfo"]) as? String;
//        if let groupId = CommonUtils.getParam(call: call, result: result, param: "groupId") as? String,
//           let identifier = CommonUtils.getParam(call: call, result: result, param: "identifier") as? String {
//
//            if nameCard != nil {
//                TIMGroupManager.sharedInstance()?.modifyGroupMemberInfoSetNameCard(groupId, user: identifier, nameCard: nameCard!, succ: {
//                    result(nil);
//                }, fail: TencentImUtils.returnErrorClosures(result: result));
//            }
//
//            if silence != nil {
//                TIMGroupManager.sharedInstance()?.modifyGroupMemberInfoSetSilence(groupId, user: identifier, stime: silence!, succ: {
//                    result(nil);
//                }, fail: TencentImUtils.returnErrorClosures(result: result));
//            }
//
//            if role != nil {
//                TIMGroupManager.sharedInstance()?.modifyGroupMemberInfoSetRole(groupId, user: identifier, role: TIMGroupMemberRole(rawValue: role!)!, succ: {
//                    result(nil);
//                }, fail: TencentImUtils.returnErrorClosures(result: result));
//            }
//            if customInfo != nil {
//                let ci = JsonUtil.getDictionaryFromJSONString(jsonString: customInfo!);
//                var customInfoData: [String: Data] = [:];
//                for (key, value) in ci {
//                    customInfoData[key] = "\(value)".data(using: String.Encoding.utf8);
//                }
//                TIMGroupManager.sharedInstance()?.modifyGroupMemberInfoSetCustomInfo(groupId, user: identifier, customInfo: customInfoData, succ: {
//                    result(nil);
//                }, fail: TencentImUtils.returnErrorClosures(result: result));
//            }
//        }
//    }
//
//    /**
//     * 获得未决群列表
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func getGroupPendencyList(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        let timestamp = ((call.arguments as! [String: Any])["timestamp"]) as? UInt64;
//        let numPerPage = ((call.arguments as! [String: Any])["numPerPage"]) as? UInt32;
//
//        let option = TIMGroupPendencyOption();
//        if timestamp != nil {
//            option.timestamp = timestamp!;
//        }
//        if numPerPage != nil {
//            option.numPerPage = numPerPage!;
//        }
//
//        TIMGroupManager.sharedInstance()?.getPendencyFromServer(option, succ: {
//            (meta, array) -> Void in
//            // 如果没有数据就直接返回
//            if array?.count == 0 {
//                result(JsonUtil.toJson(GroupPendencyPageEntiity(meta: meta!, list: [])));
//                return;
//            }
//
//            // 存储ID的集合
//            var groupIds = Set<String>();
//            var userIds = Set<String>();
//
//            var resultData: [GroupPendencyEntity] = [];
//            for item in array! {
//                if item.selfIdentifier.isEmpty {
//                    item.selfIdentifier = V2TIMManager.sharedInstance()?.getLoginUser();
//                }
//                resultData.append(GroupPendencyEntity(item: item));
//                groupIds.insert(item.groupId);
//                userIds.insert(item.selfIdentifier);
//                userIds.insert(item.fromUser);
//                userIds.insert(item.toUser);
//            }
//
//            // 当前步骤 和 最大步骤
//            var current = 0;
//            let maxIndex = (groupIds.count > 1 ? 1 : 0) + (userIds.count > 1 ? 1 : 0);
//
//            // 获得群信息
//            if groupIds.count >= 1 {
//                TIMGroupManager.sharedInstance()?.getGroupInfo(Array(groupIds), succ: {
//                    (array) -> Void in
//                    // 循环赋值
//                    for resultDatum in resultData {
//                        for item in array! {
//                            let group = item as! TIMGroupInfoResult;
//                            if group.group == resultDatum.groupId {
//                                resultDatum.groupInfo = GroupInfoEntity(groupInfo: group);
//                            }
//                        }
//                    }
//                    current += 1;
//                    if (current >= maxIndex) {
//                        result(JsonUtil.toJson(GroupPendencyPageEntiity(meta: meta!, list: resultData)))
//                    }
//                }, fail: TencentImUtils.returnErrorClosures(result: result));
//            }
//
//            if userIds.count >= 1 {
//                TIMFriendshipManager.sharedInstance()?.getUsersProfile((Array(userIds)), forceUpdate: true, succ: {
//                    (array) -> Void in
//
//                    // 循环赋值
//                    for resultDatum in resultData {
//                        for item in array! {
//                            let userInfo = item;
//                            if userInfo.identifier == resultDatum.fromUser {
//                                resultDatum.applyUserInfo = UserInfoEntity(userProfile: item);
//                            }
//
//                            if userInfo.identifier == resultDatum.toUser {
//                                resultDatum.handlerUserInfo = UserInfoEntity(userProfile: item);
//                            }
//                        }
//                    }
//                    current += 1;
//                    if (current >= maxIndex) {
//                        result(JsonUtil.toJson(GroupPendencyPageEntiity(meta: meta!, list: resultData)))
//                    }
//                }, fail: TencentImUtils.returnErrorClosures(result: result))
//            }
//        }, fail: TencentImUtils.returnErrorClosures(result: result))
//    }
//
//    /**
//     * 上报未决已读
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func reportGroupPendency(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let timestamp = ((call.arguments as! [String: Any])["timestamp"]) as? UInt64 {
//            TIMGroupManager.sharedInstance()?.pendencyReport(timestamp, succ: {
//                result(nil);
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 同意申请
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func groupPendencyAccept(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        let msg = ((call.arguments as! [String: Any])["msg"]) as? String;
//        if let groupId = CommonUtils.getParam(call: call, result: result, param: "groupId") as? String,
////           let identifier = CommonUtils.getParam(call: call, result: result, param: "identifier") as? String,
//           let addTime = CommonUtils.getParam(call: call, result: result, param: "addTime") as? UInt64 {
//            TIMGroupManager.sharedInstance()?.getPendencyFromServer(TIMGroupPendencyOption(), succ: {
//                (_, array) -> Void in
//                for item in array! {
//                    if item.groupId == groupId && item.addTime == addTime {
//                        item.accept(msg, succ: {
//                            result(nil);
//                        }, fail: TencentImUtils.returnErrorClosures(result: result))
//                    }
//                }
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 拒绝申请
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func groupPendencyRefuse(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        let msg = ((call.arguments as! [String: Any])["msg"]) as? String;
//        if let groupId = CommonUtils.getParam(call: call, result: result, param: "groupId") as? String,
////           let identifier = CommonUtils.getParam(call: call, result: result, param: "identifier") as? String,
//           let addTime = CommonUtils.getParam(call: call, result: result, param: "addTime") as? UInt64 {
//            TIMGroupManager.sharedInstance()?.getPendencyFromServer(TIMGroupPendencyOption(), succ: {
//                (_, array) -> Void in
//                for item in array! {
//                    if item.groupId == groupId && item.addTime == addTime {
//                        item.refuse(msg, succ: {
//                            result(nil);
//                        }, fail: TencentImUtils.returnErrorClosures(result: result))
//                    }
//                }
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 获取自己的资料
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func getSelfProfile(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        // 强制走后台拉取
//        let forceUpdate = ((call.arguments as! [String: Any])["forceUpdate"]) as? Bool;
//
//        if forceUpdate != nil && forceUpdate! {
//            TIMFriendshipManager.sharedInstance()?.getSelfProfile({
//                (data) -> Void in
//                result(JsonUtil.toJson(UserInfoEntity(userProfile: data!)));
//            }, fail: TencentImUtils.returnErrorClosures(result: result))
//        } else {
//            if let data = TIMFriendshipManager.sharedInstance()?.querySelfProfile() {
//                result(JsonUtil.toJson(UserInfoEntity(userProfile: data)));
//            } else {
//                TIMFriendshipManager.sharedInstance()?.getSelfProfile({
//                    (data) -> Void in
//                    result(JsonUtil.toJson(UserInfoEntity(userProfile: data!)));
//                }, fail: TencentImUtils.returnErrorClosures(result: result))
//            }
//        }
//    }
//
//    /**
//     * 修改自己的资料
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func modifySelfProfile(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let params = CommonUtils.getParam(call: call, result: result, param: "params") as? String {
//            TIMFriendshipManager.sharedInstance()?.modifySelfProfile(JsonUtil.getDictionaryFromJSONString(jsonString: params), succ: {
//                () -> Void in
//                result(nil);
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 修改好友的资料
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func modifyFriend(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let identifier = CommonUtils.getParam(call: call, result: result, param: "identifier") as? String,
//           let params = CommonUtils.getParam(call: call, result: result, param: "params") as? String {
//            TIMFriendshipManager.sharedInstance()?.modifyFriend(identifier, values: JsonUtil.getDictionaryFromJSONString(jsonString: params), succ: {
//                () -> Void in
//                result(nil);
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 删除好友
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func deleteFriends(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let ids = CommonUtils.getParam(call: call, result: result, param: "ids") as? String,
//           let delFriendType = CommonUtils.getParam(call: call, result: result, param: "delFriendType") as? Int {
//            TIMFriendshipManager.sharedInstance()?.deleteFriends(ids.components(separatedBy: ","), delType: TIMDelFriendType(rawValue: delFriendType)!, succ: {
//                (array) -> Void in
//                var resultData: [FriendResultEntity] = [];
//
//                // 填充对象
//                for item in array! {
//                    resultData.append(FriendResultEntity(result: item));
//                }
//
//                // 返回结果
//                result(JsonUtil.toJson(resultData));
//            }, fail: TencentImUtils.returnErrorClosures(result: result))
//        }
//    }
//
//    /**
//     * 添加到黑名单
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func addBlackList(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let ids = CommonUtils.getParam(call: call, result: result, param: "ids") as? String {
//            TIMFriendshipManager.sharedInstance()?.addBlackList(ids.components(separatedBy: ","), succ: {
//                (array) -> Void in
//                var resultData: [FriendResultEntity] = [];
//
//                // 填充对象
//                for item in array! {
//                    resultData.append(FriendResultEntity(result: item));
//                }
//
//                // 返回结果
//                result(JsonUtil.toJson(resultData));
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//
//    /**
//     * 从黑名单删除
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func deleteBlackList(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let ids = CommonUtils.getParam(call: call, result: result, param: "ids") as? String {
//            TIMFriendshipManager.sharedInstance()?.deleteBlackList(ids.components(separatedBy: ","), succ: {
//                (array) -> Void in
//                var resultData: [FriendResultEntity] = [];
//
//                // 填充对象
//                for item in array! {
//                    resultData.append(FriendResultEntity(result: item));
//                }
//
//                // 返回结果
//                result(JsonUtil.toJson(resultData));
//            }, fail: TencentImUtils.returnErrorClosures(result: result));
//        }
//    }
//
//    /**
//     * 获得黑名单列表
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func getBlackList(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        TIMFriendshipManager.sharedInstance()?.getBlackList({
//            (array) -> Void in
//            var resultData: [FriendEntity] = []
//            for item in array! {
//                resultData.append(FriendEntity(friend: item));
//            }
//            result(JsonUtil.toJson(resultData));
//        }, fail: TencentImUtils.returnErrorClosures(result: result))
//    }
//
//    /**
//     * 创建好友分组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func createFriendGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let groupNames = CommonUtils.getParam(call: call, result: result, param: "groupNames") as? String,
//           let ids = CommonUtils.getParam(call: call, result: result, param: "ids") as? String {
//            TIMFriendshipManager.sharedInstance()?.createFriendGroup(groupNames.components(separatedBy: ","), users: ids.components(separatedBy: ","), succ: {
//                (array) -> Void in
//                var resultData: [FriendResultEntity] = [];
//
//                // 填充对象
//                for item in array! {
//                    resultData.append(FriendResultEntity(result: item));
//                }
//
//                // 返回结果
//                result(JsonUtil.toJson(resultData));
//            }, fail: TencentImUtils.returnErrorClosures(result: result))
//        }
//    }
//
//    /**
//     * 删除好友分组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func deleteFriendGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let groupNames = CommonUtils.getParam(call: call, result: result, param: "groupNames") as? String {
//            TIMFriendshipManager.sharedInstance()?.deleteFriendGroup(groupNames.components(separatedBy: ","), succ: {
//                result(nil);
//            }, fail: TencentImUtils.returnErrorClosures(result: result))
//        }
//    }
//
//    /**
//     * 添加好友到某个分组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func addFriendsToFriendGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let groupName = CommonUtils.getParam(call: call, result: result, param: "groupName") as? String,
//           let ids = CommonUtils.getParam(call: call, result: result, param: "ids") as? String {
//            TIMFriendshipManager.sharedInstance()?.addFriends(toFriendGroup: groupName, users: ids.components(separatedBy: ","), succ: {
//                (array) -> Void in
//                var resultData: [FriendResultEntity] = [];
//
//                // 填充对象
//                for item in array! {
//                    resultData.append(FriendResultEntity(result: item));
//                }
//
//                // 返回结果
//                result(JsonUtil.toJson(resultData));
//            }, fail: TencentImUtils.returnErrorClosures(result: result))
//        }
//    }
//
//    /**
//     * 从分组删除好友
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func deleteFriendsFromFriendGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let groupName = CommonUtils.getParam(call: call, result: result, param: "groupName") as? String,
//           let ids = CommonUtils.getParam(call: call, result: result, param: "ids") as? String {
//            TIMFriendshipManager.sharedInstance()?.deleteFriends(fromFriendGroup: groupName, users: ids.components(separatedBy: ","), succ: {
//                (array) -> Void in
//                var resultData: [FriendResultEntity] = [];
//
//                // 填充对象
//                for item in array! {
//                    resultData.append(FriendResultEntity(result: item));
//                }
//
//                // 返回结果
//                result(JsonUtil.toJson(resultData));
//            }, fail: TencentImUtils.returnErrorClosures(result: result))
//        }
//    }
//
//    /**
//     * 重命名分组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func renameFriendGroup(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let oldGroupName = CommonUtils.getParam(call: call, result: result, param: "oldGroupName") as? String,
//           let newGroupName = CommonUtils.getParam(call: call, result: result, param: "newGroupName") as? String {
//            TIMFriendshipManager.sharedInstance()?.renameFriendGroup(oldGroupName, newName: newGroupName, succ: {
//                result(nil);
//            }, fail: TencentImUtils.returnErrorClosures(result: result))
//        }
//    }
//
//    /**
//     * 获得好友分组
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func getFriendGroups(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        // 组名
//        let groupNames = ((call.arguments as! [String: Any])["groupNames"]) as? String;
//
//        var groups: [String] = [];
//
//        if groupNames != nil {
//            groups = groupNames!.components(separatedBy: ",");
//        }
//
//        TIMFriendshipManager.sharedInstance()?.getFriendGroups(groups, succ: {
//            (array) -> Void in
//
//            var resultData: [FriendGroupEntity] = [];
//
//            // 填充对象
//            for item in array! {
//                resultData.append(FriendGroupEntity(group: item));
//            }
//
//            // 返回结果
//            result(JsonUtil.toJson(resultData));
//        }, fail: TencentImUtils.returnErrorClosures(result: result));
//    }
//
//    /**
//     * 消息删除
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func removeMessage(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        TencentImUtils.getTimMessage(call: call, result: result, onCallback: {
//            (message) -> Void in
//            result(message!.remove());
//        });
//    }
//
//    /**
//     * 设置消息自定义整型
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func setMessageCustomInt(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let value = CommonUtils.getParam(call: call, result: result, param: "value") as? Int32 {
//            TencentImUtils.getTimMessage(call: call, result: result, onCallback: {
//                (message) -> Void in
//                message!.setCustomInt(value);
//                result(nil);
//            });
//        }
//    }
//
//
//    /**
//     * 设置消息自定义字符串
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func setMessageCustomStr(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let value = CommonUtils.getParam(call: call, result: result, param: "value") as? String {
//            TencentImUtils.getTimMessage(call: call, result: result, onCallback: {
//                (message) -> Void in
//                message!.setCustomData(value.data(using: String.Encoding.utf8));
//                result(nil);
//            });
//        }
//    }
//
//    /**
//     * 下载视频图片
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func downloadVideoImage(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        let path = ((call.arguments as! [String: Any])["path"]) as? String;
//        if path != nil && FileManager.default.fileExists(atPath: path!) {
//            result(path);
//            return;
//        }
//
//        TencentImUtils.getTimMessage(call: call, result: result, onCallback: {
//            (message) -> Void in
//            let elem: TIMElem = message!.getElem(0);
//            if elem is TIMVideoElem {
//                let videoElem: TIMVideoElem = elem as! TIMVideoElem;
//                var finalPath: String? = path;
//                if finalPath == nil || finalPath! == "" {
//                    finalPath = NSTemporaryDirectory() + "/" + videoElem.snapshot.uuid;
//                }
//
//                // 如果文件存在则不进行下载
//                if (FileManager.default.fileExists(atPath: finalPath!)) {
//                    result(finalPath);
//                    return;
//                }
//
//                TencentImUtils.getMessageInfo(timMessages: [message!], onSuccess: {
//                    (array) -> Void in
//                    videoElem.snapshot!.getImage(finalPath!, progress: {
//                        (current, total) -> Void in
//                        self.invokeListener(type: ListenerType.DownloadProgress, params: [
//                            "message": array[0],
//                            "path": finalPath!,
//                            "currentSize": current,
//                            "totalSize": total
//                        ]);
//                    }, succ: {
//                        () -> Void in
//                        result(finalPath!);
//                    }, fail: TencentImUtils.returnErrorClosures(result: result))
//                }, onFail: TencentImUtils.returnErrorClosures(result: result));
//            }
//        });
//    }
//
//    /**
//     * 下载视频
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func downloadVideo(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        let path = ((call.arguments as! [String: Any])["path"]) as? String;
//        if path != nil && FileManager.default.fileExists(atPath: path!) {
//            result(path!);
//            return;
//        }
//
//        TencentImUtils.getTimMessage(call: call, result: result, onCallback: {
//            (message) -> Void in
//            let elem: TIMElem = message!.getElem(0);
//            if elem is TIMVideoElem {
//                let videoElem: TIMVideoElem = elem as! TIMVideoElem;
//                var finalPath: String? = path;
//                if finalPath == nil || finalPath! == "" {
//                    finalPath = NSTemporaryDirectory() + "/" + videoElem.video.uuid;
//                }
//
//                // 如果文件存在则不进行下载
//                if (FileManager.default.fileExists(atPath: finalPath!)) {
//                    result(finalPath!);
//                    return;
//                }
//
//                TencentImUtils.getMessageInfo(timMessages: [message!], onSuccess: {
//                    (array) -> Void in
//                    videoElem.video!.getVideo(finalPath!, progress: {
//                        (current, total) -> Void in
//                        self.invokeListener(type: ListenerType.DownloadProgress, params: [
//                            "message": array[0],
//                            "path": finalPath!,
//                            "currentSize": current,
//                            "totalSize": total
//                        ]);
//                    }, succ: {
//                        () -> Void in
//                        result(finalPath!);
//                    }, fail: TencentImUtils.returnErrorClosures(result: result))
//                }, onFail: TencentImUtils.returnErrorClosures(result: result));
//            }
//        });
//    }
//
//    /**
//     * 下载语音
//     *
//     * @param methodCall 方法调用对象
//     * @param result     返回结果对象
//     */
//    private func downloadSound(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        let path = ((call.arguments as! [String: Any])["path"]) as? String;
//        if path != nil && FileManager.default.fileExists(atPath: path!) {
//            result(path!);
//            return;
//        }
//
//        TencentImUtils.getTimMessage(call: call, result: result, onCallback: {
//            (message) -> Void in
//            let elem: TIMElem = message!.getElem(0);
//            if elem is TIMSoundElem {
//                let soundElem: TIMSoundElem = elem as! TIMSoundElem;
//                var finalPath: String? = path;
//                if finalPath == nil || finalPath! == "" {
//                    finalPath = NSTemporaryDirectory() + "/" + soundElem.uuid;
//                }
//
//                // 如果文件存在则不进行下载
//                if (FileManager.default.fileExists(atPath: finalPath!)) {
//                    result(finalPath!);
//                    return;
//                }
//
//                TencentImUtils.getMessageInfo(timMessages: [message!], onSuccess: {
//                    (array) -> Void in
//                    soundElem.getSound(finalPath!, progress: {
//                        (current, total) -> Void in
//                        self.invokeListener(type: ListenerType.DownloadProgress, params: [
//                            "message": array[0],
//                            "path": finalPath!,
//                            "currentSize": current,
//                            "totalSize": total
//                        ]);
//                    }, succ: {
//                        () -> Void in
//                        result(finalPath!);
//                    }, fail: TencentImUtils.returnErrorClosures(result: result))
//                }, onFail: TencentImUtils.returnErrorClosures(result: result));
//            }
//        });
//    }
//
//    /**
//     * 查找一条消息
//     */
//    private func findMessage(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        TencentImUtils.getTimMessage(call: call, result: result, onCallback: {
//            (message) -> Void in
//            TencentImUtils.getMessageInfo(timMessages: [message!], onSuccess: {
//                (array) -> Void in
//                result(JsonUtil.toJson(array[0] as! MessageEntity));
//            }, onFail: TencentImUtils.returnErrorClosures(result: result));
//        });
//    }
//
//    /**
//     * 设置离线推送配置
//     */
//    private func setOfflinePushSettings(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        let enabled = ((call.arguments as! [String: Any])["enabled"]) as? Bool;
//        let c2cSound = ((call.arguments as! [String: Any])["c2cSound"]) as? String;
//        let groupSound = ((call.arguments as! [String: Any])["groupSound"]) as? String;
//        let videoSound = ((call.arguments as! [String: Any])["videoSound"]) as? String;
//
//
//        let config = TIMAPNSConfig();
//        if enabled != nil {
//            config.openPush = enabled! == true ? 1 : 2;
//        }
//        if c2cSound != nil {
//            config.c2cSound = c2cSound!;
//        }
//        if groupSound != nil {
//            config.groupSound = groupSound!;
//        }
//        if videoSound != nil {
//            config.videoSound = videoSound!;
//        }
//
//        V2TIMManager.sharedInstance().setAPNS(config, succ: {
//            result(nil);
//        }, fail: TencentImUtils.returnErrorClosures(result: result))
//    }
//
//    /**
//     * 设置离线推送Token
//     */
//    private func setOfflinePushToken(call: FlutterMethodCall, result: @escaping FlutterResult) {
//        if let token = CommonUtils.getParam(call: call, result: result, param: "token") as? String,
//           let bussid = CommonUtils.getParam(call: call, result: result, param: "bussid") as? UInt32 {
//
//            let config = TIMTokenParam();
//            config.token = CommonUtils.dataWithHexString(hex: token);
//            config.busiId = bussid;
//            V2TIMManager.sharedInstance().setToken(config, succ: {
//                result(nil);
//            }, fail: TencentImUtils.returnErrorClosures(result: result))
//        }
//    }


    /**
     * 调用监听器
     *
     * @param type   类型
     * @param params 参数
     */
    private func invokeListener(type: ListenerType, params: Any?) {
        var resultParams: [String: Any] = [:];
        resultParams["type"] = type;
        if let p = params {
            resultParams["params"] = JsonUtil.toJson(p);
        }
        SwiftTencentImPlugin.channel!.invokeMethod(SwiftTencentImPlugin.LISTENER_FUNC_NAME, arguments: JsonUtil.toJson(resultParams));
    }
}
