/// 监听器类型枚举
enum TencentImListenerTypeEnum {
  /// 新消息通知
  NewMessage,

  /// C2C已读回执
  C2CReadReceipt,

  /// 消息撤回
  MessageRevoked,

  /// 同步服务开始
  SyncServerStart,

  /// 同步服务完成
  SyncServerFinish,

  /// 同步服务失败
  SyncServerFailed,

  /// 新会话
  NewConversation,

  /// 会话刷新
  ConversationChanged,

  /// 好友申请新增通知
  FriendApplicationListAdded,

  /// 好友申请删除通知
  FriendApplicationListDeleted,

  /// 好友申请已读通知
  FriendApplicationListRead,

  /// 好友新增通知
  FriendListAdded,

  /// 好友删除通知
  FriendListDeleted,

  /// 黑名单新增通知
  BlackListAdd,

  /// 黑名单删除通知
  BlackListDeleted,

  /// 好友资料更新通知
  FriendInfoChanged,

  /// 有用户加入群
  MemberEnter,

  /// 有用户离开群
  MemberLeave,

  /// 有用户被拉入群
  MemberInvited,

  /// 有用户被踢出群
  MemberKicked,

  /// 群成员信息被修改
  MemberInfoChanged,

  /// 创建群
  GroupCreated,

  /// 群被解散
  GroupDismissed,

  /// 群被回收
  GroupRecycled,

  /// 群信息被修改
  GroupInfoChanged,

  /// 有新的加群申请
  ReceiveJoinApplication,

  /// 加群信息已被管理员处理
  ApplicationProcessed,

  /// 指定管理员身份
  GrantAdministrator,

  /// 取消管理员身份
  RevokeAdministrator,

  /// 主动退出群组
  QuitFromGroup,

  /// 收到 RESTAPI 下发的自定义系统消息
  ReceiveRESTCustomData,

  /// 收到群属性更新的回调
  GroupAttributeChanged,

  /// 正在连接到腾讯云服务器
  Connecting,

  /// 网络连接成功
  ConnectSuccess,

  /// 网络连接失败
  ConnectFailed,

  /// 踢下线
  KickedOffline,

  /// 当前用户的资料发生了更新
  SelfInfoUpdated,

  /// 用户登录的 userSig 过期（用户需要重新获取 userSig 后登录）
  UserSigExpired,

  /// 收到信令邀请
  ReceiveNewInvitation,

  /// 信令被邀请者接受邀请
  InviteeAccepted,

  /// 信令被邀请者拒绝邀请
  InviteeRejected,

  /// 信令邀请被取消
  InvitationCancelled,

  /// 信令邀请超时
  InvitationTimeout,

  /// 下载进度
  DownloadProgress,

  /// 消息发送成功
  MessageSendSucc,

  /// 消息发送失败
  MessageSendFail,

  /// 消息发送进度更新
  MessageSendProgress,
}
