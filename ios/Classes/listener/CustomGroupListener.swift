//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation
import ImSDK

/// 群监听器
class CustomGroupListener: NSObject, V2TIMGroupListener {
    /// 有用户加入群（全员能够收到）
    func onMemberEnter(_ groupID: String!, memberList: [V2TIMGroupMemberInfo]!) {

    }

    /// 有用户离开群（全员能够收到）
    func onMemberLeave(_ groupID: String!, member: V2TIMGroupMemberInfo!) {

    }


    /// 某些人被拉入某群（全员能够收到）
    func onMemberInvited(_ groupID: String!, opUser: V2TIMGroupMemberInfo!, memberList: [V2TIMGroupMemberInfo]!) {

    }

    /// 某些人被踢出某群（全员能够收到）
    func onMemberKicked(_ groupID: String!, opUser: V2TIMGroupMemberInfo!, memberList: [V2TIMGroupMemberInfo]!) {

    }

    /// 群成员信息被修改（全员能收到）
    func onMemberInfoChanged(_ groupID: String!, changeInfoList: [V2TIMGroupMemberChangeInfo]!) {

    }

    /// 创建群（主要用于多端同步）
    func onGroupCreated(_ groupID: String!) {

    }

    /// 群被解散了（全员能收到）
    func onGroupDismissed(_ groupID: String!, opUser: V2TIMGroupMemberInfo!) {

    }

    /// 群被回收（全员能收到）
    func onGroupRecycled(_ groupID: String!, opUser: V2TIMGroupMemberInfo!) {

    }

    /// 群信息被修改（全员能收到）
    func onGroupInfoChanged(_ groupID: String!, changeInfoList: [V2TIMGroupChangeInfo]!) {

    }

    /// 有新的加群请求（只有群主或管理员会收到）
    func onReceiveJoinApplication(_ groupID: String!, member: V2TIMGroupMemberInfo!, opReason: String!) {

    }

    /// 加群请求已经被群主或管理员处理了（只有申请人能够收到）
    func onApplicationProcessed(_ groupID: String!, opUser: V2TIMGroupMemberInfo!, opResult isAgreeJoin: Bool, opReason: String!) {

    }

    /// 指定管理员身份
    func onGrantAdministrator(_ groupID: String!, opUser: V2TIMGroupMemberInfo!, memberList: [V2TIMGroupMemberInfo]!) {

    }

    /// 取消管理员身份
    func onRevokeAdministrator(_ groupID: String!, opUser: V2TIMGroupMemberInfo!, memberList: [V2TIMGroupMemberInfo]!) {

    }

    /// 主动退出群组（主要用于多端同步，直播群（AVChatRoom）不支持）
    func onQuit(fromGroup groupID: String!) {

    }

    /// 收到 RESTAPI 下发的自定义系统消息
    func onReceiveRESTCustomData(_ groupID: String!, data: Data!) {

    }

    /// 收到群属性更新的回调
    func onGroupAttributeChanged(_ groupID: String!, attributes: NSMutableDictionary!) {

    }
}
