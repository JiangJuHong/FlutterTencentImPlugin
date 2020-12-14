//  Created by 蒋具宏 on 2020/2/15.
//  监听器类型
public enum ListenerType {
    /// 新消息通知
    case NewMessage

    /// C2C已读回执
    case C2CReadReceipt

    /// 消息撤回
    case MessageRevoked

    /// 同步服务开始
    case SyncServerStart

    /// 同步服务完成
    case SyncServerFinish

    /// 同步服务失败
    case SyncServerFailed

    /// 新会话
    case NewConversation

    /// 会话刷新
    case ConversationChanged

    /// 好友申请新增通知
    case FriendApplicationListAdded

    /// 好友申请删除通知
    case FriendApplicationListDeleted

    /// 好友申请已读通知
    case FriendApplicationListRead

    /// 好友新增通知
    case FriendListAdded

    /// 好友删除通知
    case FriendListDeleted

    /// 黑名单新增通知
    case BlackListAdd

    /// 黑名单删除通知
    case BlackListDeleted

    /// 好友资料更新通知
    case FriendInfoChanged

    /// 有用户加入群
    case MemberEnter

    /// 有用户离开群
    case MemberLeave

    /// 有用户被拉入群
    case MemberInvited

    /// 有用户被踢出群
    case MemberKicked

    /// 群成员信息被修改
    case MemberInfoChanged

    /// 创建群
    case GroupCreated

    /// 群被解散
    case GroupDismissed

    /// 群被回收
    case GroupRecycled

    /// 群信息被修改
    case GroupInfoChanged

    /// 有新的加群申请
    case ReceiveJoinApplication

    /// 加群信息已被管理员处理
    case ApplicationProcessed

    /// 指定管理员身份
    case GrantAdministrator

    /// 取消管理员身份
    case RevokeAdministrator

    /// 主动退出群组
    case QuitFromGroup

    /// 收到 RESTAPI 下发的自定义系统消息
    case ReceiveRESTCustomData

    /// 收到群属性更新的回调
    case GroupAttributeChanged

    /// 正在连接到腾讯云服务器
    case Connecting

    /// 网络连接成功
    case ConnectSuccess

    /// 网络连接失败
    case ConnectFailed

    /// 踢下线
    case KickedOffline

    /// 当前用户的资料发生了更新
    case SelfInfoUpdated

    /// 用户登录的 userSig 过期（用户需要重新获取 userSig 后登录）
    case UserSigExpired

    /// 收到信令邀请
    case ReceiveNewInvitation

    /// 信令被邀请者接受邀请
    case InviteeAccepted

    /// 信令被邀请者拒绝邀请
    case InviteeRejected

    /// 信令邀请被取消
    case InvitationCancelled

    /// 信令邀请超时
    case InvitationTimeout

    /// 下载进度
    case DownloadProgress

    /// 消息发送成功
    case MessageSendSucc

    /// 消息发送失败
    case MessageSendFail

    /// 消息发送进度更新
    case MessageSendProgress
}
