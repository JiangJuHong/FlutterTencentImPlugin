import ImSDK

//
//  MessageEntity.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/2/10.
//
public class MessageEntity : NSObject{
    /**
     * 消息ID
     */
    var id : String?;
    
    /**
     * 唯一ID
     */
    var uniqueId : UInt64?;
    
    /**
     * 对方是否已读
     */
    var peerReaded : Bool?;
    
    /**
     * 自己是否已读
     */
    var read : Bool?;
    
    /**
     * 当前登录用户是否是发送方
     */
    var `self` : Bool?;
    
    /**
     * 自定义整数
     */
    var customInt : Int32?;
    
    /**
     * 自定义值
     */
    var customStr : String?;
    
    /**
     * 消息时间戳
     */
    var timestamp : Date?;
    
    /**
     * 消息发送方
     */
    var sender : String?;
    
    /**
     * 会话ID
     */
    var sessionId : String?
    
    /**
     * 会话类型
     */
    var sessionType : SessionType?;
    
    /**
     * 发送人->用户信息
     */
    var userInfo : UserInfoEntity?;
    
    /**
     * 发送人->群成员信息
     */
    var groupMemberInfo : TIMGroupMemberInfo?;
    
    /**
     * 节点内容
     */
    var elemList : [NodeEntity]?;
    
    /**
     * 消息状态
     */
    var status : MessageStatus?;
    
    override init() {
    }
    
    init(message : TIMMessage) {
        super.init();
        self.id = message.msgId();
        self.uniqueId = message.uniqueId();
        self.peerReaded = message.isPeerReaded();
        self.read = message.isReaded();
        self.`self` = message.isSelf();
        self.customInt = message.customInt();
        self.customStr = String(data: message.customData()!, encoding: String.Encoding.utf8);
        self.timestamp = message.timestamp();
        self.elemList = TencentImUtils.getArrayElement(message: message);
        self.groupMemberInfo = message.getSenderGroupMemberProfile();
        self.sender = message.sender();
        self.sessionId = message.getConversation().getReceiver();
        self.sessionType = SessionType.getByTIMConversationType(type: (message.getConversation()?.getType())!);
        self.status = MessageStatus.getByTIMMessageStatus(status:message.status());
    }
}
