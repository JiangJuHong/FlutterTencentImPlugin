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
    public static func getConversationInfo(conversations : [TIMConversation]){
        var resultData : [SessionEntity] = [];
        
        if (conversations.count == 0) {
            //            callback.onSuccess(resultData);
            return;
        }
        
        // 需要获取用户信息的列表
        var userInfo = [String: SessionEntity]();
        // 需要获取群信息列表
        var groupInfo = [String: SessionEntity]();
        
        // 根据会话列表封装会话信息
        for timConversation in conversations{
            // 封装会话信息
            var entity = SessionEntity();
            entity.id = timConversation.getReceiver();
            entity.nickname = timConversation.getGroupName();
            entity.type = timConversation.getType();
            entity.unreadMessageNum = timConversation.getUnReadMessageNum();
            
            // 封装获取资料对象
            if timConversation.getType() == TIMConversationType.C2C {
                userInfo[timConversation.getReceiver()] = entity;
            } else if timConversation.getType() == TIMConversationType.GROUP {
                groupInfo[timConversation.getReceiver()] = entity;
            }
            
            // 获取最后一条消息
            var lastMsg = timConversation.getLastMsg();
            if (lastMsg != nil) {
                // 封装消息信息
                var messageEntity = MessageEntity();
//                messageEntity.id = lastMsg.getMsgId();
                messageEntity.timestamp = lastMsg?.timestamp();
                //                messageEntity.setId(lastMsg.getMsgId());
                //                messageEntity.setElemList(TencentImUtils.getArrrElement(lastMsg));
                entity.message = messageEntity;
            }
            resultData.append(entity);
            
            print(userInfo)
            print(groupInfo)
        }
    }
}
