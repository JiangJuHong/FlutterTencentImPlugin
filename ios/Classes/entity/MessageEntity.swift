import ImSDK

//
//  MessageEntity.swift
//  tencent_im_plugin
//
//  Created by 蒋具宏 on 2020/2/10.
//
public class MessageEntity: NSObject {

    /**
     * 消息 ID
     */
    var msgID: String?;

    /**
     * 消息时间戳
     */
    var timestamp: Date?;

    /**
     * 消息发送者 userID
     */
    var sender: String?;

    /**
     * 消息发送者昵称
     */
    var nickName: String?;

    /**
     * 好友备注。如果没有拉取过好友信息或者不是好友，返回 null
     */
    var friendRemark: String?;

    /**
     * 发送者头像 url
     */
    var faceUrl: String?;

    /**
     * 群组消息，nameCard 为发送者的群名片
     */
    var nameCard: String?;

    /**
     * 群组消息，groupID 为接收消息的群组 ID，否则为 null
     */
    var groupID: String?;

    /**
     * 单聊消息，userID 为会话用户 ID，否则为 null。 假设自己和 userA 聊天，无论是自己发给 userA 的消息还是 userA 发给自己的消息，这里的 userID 均为 userA
     */
    var userID: String?;

    /**
     * 消息发送状态
     */
    var status: Int?;

    /**
     * 消息类型
     */
    var elemType: Int?;

    /**
     * 消息自定义数据（本地保存，不会发送到对端，程序卸载重装后失效）
     */
    var localCustomData: Data?;

    /**
     * 消息自定义数据（本地保存，不会发送到对端，程序卸载重装后失效）
     */
    var localCustomInt: Int32?;

    /**
     * 消息发送者是否是自己
     */
    var `self`: Bool?;

    /**
     * 消息自己是否已读
     */
    var read: Bool?;

    /**
     * 消息对方是否已读（只有 C2C 消息有效）
     */
    var peerRead: Bool?;

    /**
     * 消息优先级
     */
    var priority: Int?;

    /**
     * 消息的离线推送信息
     */
    var offlinePushInfo: V2TIMOfflinePushInfo?;

    /**
     * 群@用户列表
     */
    var groupAtUserList: [String]?;

    /**
     * 消息的序列号
     * 群聊中的消息序列号云端生成，在群里是严格递增且唯一的。 单聊中的序列号是本地生成，不能保证严格递增且唯一。
     */
    var seq: UInt64?;

    /**
     * 描述信息
     */
    var note: String?;

    /**
     * 节点信息
     */
    var node: AbstractMessageEntity?;

    override init() {
    }

    init(message: V2TIMMessage) {
        super.init();
        // 设置基本信息
        self.msgID = message.msgID;
        self.timestamp = message.timestamp;
        self.sender = message.sender;
        self.nickName = message.nickName;
        self.friendRemark = message.friendRemark;
        self.faceUrl = message.faceURL;
        self.nameCard = message.nameCard;
        self.groupID = message.groupID;
        self.userID = message.userID;
        self.status = message.status.rawValue;
        self.elemType = message.elemType.rawValue;
        self.localCustomData = message.localCustomData;
        self.localCustomInt = message.localCustomInt;
        self.`self` = message.isSelf;
        self.read = message.isRead;
        self.peerRead = message.isPeerRead;
//        self.priority
//        self.offlinePushInfo
        self.groupAtUserList = (message.groupAtUserList as? [String]);
        self.seq = message.seq;

        // 解析接口
        let nodeType = MessageNodeType.getMessageNodeTypeByV2TIMConstant(constant: self.elemType!);
        if nodeType != MessageNodeType.None {
            let messageNodeInterface = nodeType.messageNodeInterface();
            let elem = MessageNodeType.getElemByMessage(message: message)!;
            self.note = messageNodeInterface.getNote(elem: elem);
            self.node = messageNodeInterface.analysis(elem: elem);
        }
    }
}
