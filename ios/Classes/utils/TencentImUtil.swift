import ImSDK

//  腾讯云工具类
//  Created by 蒋具宏 on 2020/2/10.
public class TencentImUtils {
    /**
     * 返回[错误返回闭包]，腾讯云IM通用格式
     */
    public static func returnErrorClosures(result: @escaping FlutterResult) -> TIMFail {
        return {
            (code: Int32, desc: Optional<String>) -> Void in
            result(
                    FlutterError(code: "\(code)", message: desc!, details: desc!)
            );
        };
    }

    /**
     * 获得会话信息
     *
     * @param callback      回调对象
     * @param conversations 原生会话列表
     */
    public static func getConversationInfo(conversations: [TIMConversation], onSuccess: @escaping GetInfoSuc, onFail: @escaping GetInfoFail) {
        var resultData: [SessionEntity] = [];

        if (conversations.count == 0) {
            onSuccess(resultData);
            return;
        }

        // 需要获取用户信息的列表
        var userInfo = [String: [SessionEntity]]();
        // 需要获取群信息列表
        var groupInfo = [String: SessionEntity]();

        // 根据会话列表封装会话信息
        for timConversation in conversations {
            // 封装会话信息
            let entity = SessionEntity();
            entity.id = timConversation.getReceiver();
            entity.nickname = timConversation.getGroupName();
            entity.type = SessionType.getByTIMConversationType(type: timConversation.getType());
            entity.unreadMessageNum = timConversation.getUnReadMessageNum();

            // 封装获取资料对象
            if timConversation.getType() == TIMConversationType.C2C {
                var sessionArrry: [SessionEntity] = userInfo[timConversation.getReceiver()] ?? [];
                sessionArrry.append(entity);
                userInfo[timConversation.getReceiver()] = sessionArrry;
            } else if timConversation.getType() == TIMConversationType.GROUP {
                groupInfo[timConversation.getReceiver()] = entity;
            }

            // 获取最后一条消息
            let lastMsg = timConversation.getLastMsg();
            if (lastMsg != nil) {
                var sessionArrry: [SessionEntity] = userInfo[lastMsg!.sender()] ?? [];
                sessionArrry.append(entity);
                userInfo[lastMsg!.sender()] = sessionArrry;
                entity.message = MessageEntity(message: lastMsg!);
            }
            resultData.append(entity);
        }

        // 如果未登录，直接返回信息，不包含群信息和用户信息
        if (TIMManager.sharedInstance().getLoginUser() == nil) {
            onSuccess(resultData);
            return;
        }


        // 初始化计数器
        let maxIndex = (userInfo.count != 0 ? 1 : 0) + (groupInfo.count != 0 ? 1 : 0);
        if (maxIndex == 0) {
            onSuccess([]);
            return;
        }

        // 当前计数器
        var currentIndex = 0;

        // 获取群资料
        if (groupInfo.count != 0) {
            TIMGroupManager.sharedInstance()?.getGroupInfo(Array(groupInfo.keys), succ: {
                (array) -> Void in
                // 设置会话资料
                for item in array! {
                    let groupInfoResult = item as! TIMGroupInfoResult;
                    if let sessionEntity = groupInfo[groupInfoResult.group] {
                        sessionEntity.group = GroupInfoEntity(groupInfo: groupInfoResult);
                        sessionEntity.nickname = groupInfoResult.groupName;
                        sessionEntity.faceUrl = groupInfoResult.faceURL;
                    }
                }

                // 回调成功
                currentIndex += 1;
                if (currentIndex >= maxIndex) {
                    onSuccess(resultData);
                }
            }, fail: onFail);
        }

        // 获取用户资料
        if userInfo.count != 0 {
            TIMFriendshipManager.sharedInstance()?.getUsersProfile(Array(userInfo.keys), forceUpdate: true, succ: {
                (array) -> Void in
                // 设置会话资料
                for item in array! {
                    let userProfile = item as TIMUserProfile;

                    let sessionArrays: [SessionEntity]? = userInfo[userProfile.identifier];
                    if sessionArrays != nil && sessionArrays?.count != 0 {
                        for sessionEntity in sessionArrays! {
                            // 会话用户ID
                            if userProfile.identifier == sessionEntity.id {
                                sessionEntity.userProfile = UserInfoEntity(userProfile: userProfile);
                                sessionEntity.nickname = userProfile.nickname;
                                sessionEntity.faceUrl = userProfile.faceURL;
                            }

                            // 最后一条消息用户ID
                            if userProfile.identifier == sessionEntity.message?.sender {
                                sessionEntity.message?.userInfo = UserInfoEntity(userProfile: userProfile);
                            }
                        }
                    }

                }

                // 回调成功
                currentIndex += 1;
                if (currentIndex >= maxIndex) {
                    onSuccess(resultData);
                }
            }, fail: onFail);
        }
    }

    /**
     * 根据会话ID和会话类型获得会话对象
     *
     * @param sessionId      会话ID
     * @param sessionTypeStr 会话类型字符串模式
     * @param result    返回结果对象，如果传递了该属性，那么在获取会话失败时会自动返回Error
     * @return 会话对象
     */
    public static func getSession(sessionId: String, sessionTypeStr: String, result: FlutterResult?) -> TIMConversation? {
        if let sessionType = SessionType.getEnumByName(name: sessionTypeStr) {
            if let session = TIMManager.sharedInstance()?.getConversation(TIMConversationType(rawValue: sessionType.rawValue)!, receiver: sessionId) {
                return session;
            }
        }
        if result != nil {
            result!(
                    FlutterError(code: "100", message: "Execution Error", details: "Session not found")
            );
        }
        return nil;
    }

    /**
     *  获得腾讯云IM的Message
     */
    public static func getTimMessage(call: FlutterMethodCall, result: @escaping FlutterResult, onCallback: @escaping GetTimMessage) {
        getTimMessage(call: call, result: result, name: "message", onCallback: onCallback);
    }

    /**
     *  获得腾讯云IM的Message
     */
    public static func getTimMessage(call: FlutterMethodCall, result: @escaping FlutterResult, name: String, onCallback: @escaping GetTimMessage) {
        let messageStr = ((call.arguments as! [String: Any])[name]) as? String;
        if messageStr != nil && messageStr != "null" {
            let message = JsonUtil.getDictionaryFromJSONString(jsonString: messageStr!);
            let sessionId = message["sessionId"];
            let sessionType = message["sessionType"];
            let rand = message["rand"];
            let seq = message["seq"];
            let timestamp = message["timestamp"];
            let isSelf = message["self"];
            if sessionId == nil || sessionType == nil || rand == nil || seq == nil {
                result(
                        FlutterError(code: "5", message: "Missing parameter", details: "Parameter `sessionId` or `sessionType` or `rand` or `seq` is null!")
                );
                return;
            }

            if let session = TencentImUtils.getSession(sessionId: sessionId as! String, sessionTypeStr: sessionType as! String, result: result) {
                let locator = TIMMessageLocator();
                locator.seq = seq as! UInt64;
                locator.rand = rand as! UInt64;
                locator.isSelf = isSelf == nil || (isSelf as! Bool);
                if timestamp != nil {
                    locator.time = time_t(timestamp as! UInt64);
                }

                session.findMessages([locator], succ: {
                    (array) -> Void in
                    if array == nil || array!.count == 0 {
                        result(
                                FlutterError(code: "-1", message: "No messages found", details: "No messages found")
                        );
                        return;
                    }


                    onCallback((array![0] as! TIMMessage));
                }, fail: TencentImUtils.returnErrorClosures(result: result))
            }
        } else {
            onCallback(nil);
        }
    }

    /**
     * 获得完整的消息对象
     *
     * @param timMessages 消息列表
     * @param callBack    完成回调
     */
    public static func getMessageInfo(timMessages: [TIMMessage], onSuccess: @escaping GetInfoSuc, onFail: @escaping GetInfoFail) {
        var resultData: [MessageEntity] = [];

        if (timMessages.count == 0) {
            onSuccess(resultData);
            return;
        }

        // 根据消息列表封装消息信息
        for item in timMessages {
            let ms = MessageEntity(message: item);
            resultData.append(ms);
        }

        // 根据消息时间排序
        resultData.sort(by: {
            (o1, o2) -> Bool in
            (o1.timestamp?.compare(o2.timestamp!).rawValue)! <= 0
        });


        // 如果未登录，则直接返回
        if (TIMManager.sharedInstance().getLoginUser() == nil) {
            onSuccess(resultData);
            return;
        }

        // 获取用户资料(存储Key和下标，方便添加时快速查找)
        var userIds = [String: [Int]]();
        for i in 0..<resultData.count {
            let messageDatum = resultData[i];
            // 获得用户信息
            var userArray: [Int] = userIds[messageDatum.sender!] ?? [];
            userArray.append(i);
            userIds[messageDatum.sender!] = userArray;
        }
        TIMFriendshipManager.sharedInstance()?.getUsersProfile(Array(userIds.keys), forceUpdate: true, succ: {
            (array) -> Void in
            // 设置用户资料
            for item in array! {
                for index in userIds[item.identifier]! {
                    resultData[index].userInfo = UserInfoEntity(userProfile: item);
                }
            }

            // 回调成功
            onSuccess(resultData);
        }, fail: onFail);
    }
}

/**
 *  获取信息成功回调
 */
public typealias GetInfoSuc = (_ array: [Any]) -> Void;

/**
 *  获取信息失败回调
 */
public typealias GetInfoFail = (_ code: Int32, _ desc: Optional<String>) -> Void;

/**
 *  获取TIM消息成功回调
 */
public typealias GetTimMessage = (_ message: TIMMessage?) -> Void;

/**
 *  获取TIM消息成功回调
 */
public typealias GetMessage = (_ message: MessageEntity) -> Void;
