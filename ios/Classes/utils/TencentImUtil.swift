import ImSDK

//  腾讯云工具类
//  Created by 蒋具宏 on 2020/2/10.
public class TencentImUtils{
    /**
     * 返回[错误返回闭包]，腾讯云IM通用格式
     */
    public static func returnErrorClosures(result: @escaping FlutterResult)->TIMFail{
        return {
            (code : Int32,desc : Optional<String>)-> Void in
            result(
                FlutterError(code: "\(code)",  message: "Execution Error",details: desc!)
            );
        };
    }
    
    /**
     * 获得会话信息
     *
     * @param callback      回调对象
     * @param conversations 原生会话列表
     */
    public static func getConversationInfo(conversations : [TIMConversation],onSuccess : @escaping GetConversationInfoSuc, onFail :  @escaping GetConversationInfoFail){
        var resultData : [SessionEntity] = [];
        
        if (conversations.count == 0) {
            onSuccess(resultData);
            return;
        }
        
        // 需要获取用户信息的列表
        var userInfo = [String: SessionEntity]();
        // 需要获取群信息列表
        var groupInfo = [String: SessionEntity]();
        
        // 根据会话列表封装会话信息
        for timConversation in conversations{
            // 封装会话信息
            let entity = SessionEntity();
            entity.id = timConversation.getReceiver();
            entity.nickname = timConversation.getGroupName();
            entity.type = SessionType.getByTIMConversationType(type: timConversation.getType());
            entity.unreadMessageNum = timConversation.getUnReadMessageNum();
            
            // 封装获取资料对象
            if timConversation.getType() == TIMConversationType.C2C {
                userInfo[timConversation.getReceiver()] = entity;
            } else if timConversation.getType() == TIMConversationType.GROUP {
                groupInfo[timConversation.getReceiver()] = entity;
            }
            
            // 获取最后一条消息
            let lastMsg = timConversation.getLastMsg();
            if (lastMsg != nil) {
                entity.message = MessageEntity(message: lastMsg!);
            }
            resultData.append(entity);
        }
        
        // 初始化计数器
        let  maxIndex = (userInfo.count != 0 ? 1 : 0) + (groupInfo.count != 0 ? 1 : 0);
        if (maxIndex == 0) {
            onSuccess([]);
            return;
        }
        
        // 当前计数器
        var currentIndex = 0;
        
        // 获取群资料
        if (groupInfo.count != 0) {
            TIMGroupManager.sharedInstance()?.getGroupInfo(Array(groupInfo.keys), succ: {
                (array)-> Void in
                // 设置会话资料
                for item in array!{
                    let groupInfoResult = item as! TIMGroupInfoResult;
                    if let sessionEntity = groupInfo[groupInfoResult.group]{
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
            }, fail:onFail);
        }
        
        // 获取用户资料
        if userInfo.count != 0{
            TIMFriendshipManager.sharedInstance()?.getUsersProfile(Array(userInfo.keys), forceUpdate: true, succ: {
                (array)-> Void in
                // 设置会话资料
                for item in array!{
                    let userProfile = item as TIMUserProfile;
                    if let sessionEntity = userInfo[userProfile.identifier]{
                        sessionEntity.userProfile = UserInfoEntity(userProfile: userProfile);
                        sessionEntity.nickname = userProfile.nickname;
                        sessionEntity.faceUrl = userProfile.faceURL;
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
     * 根据Message对象获得所有节点
     *
     * @param message 消息对象
     * @return 所有节点对象
     */
    public static func getArrayElement(message : TIMMessage) -> [NodeEntity]{
        var elems : [NodeEntity] = [];
        for index in 0..<message.elemCount() {
            let elem : TIMElem = message.getElem(index)
            elems.append(NodeEntity.getNodeEntityByTIMElem(elem: elem));
        }
        return elems;
    }
}

/**
 *  会话获取成功回调
 */
public typealias GetConversationInfoSuc = (_ array : [SessionEntity]) -> Void;

/**
 *  会话获取失败回调
 */
public typealias GetConversationInfoFail = (_ code : Int32, _ desc : Optional<String>) -> Void;
