//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation
import ImSDK

/// 自定义信令监听
class CustomSignalingListener: NSObject, V2TIMSignalingListener {
    ///收到新邀请时
    func onReceiveNewInvitation(_ inviteID: String!, inviter: String!, groupID: String!, inviteeList: [String]!, data: String!) {

    }


    /// 被邀请者接受邀请
    func onInviteeAccepted(_ inviteID: String!, invitee: String!, data: String!) {

    }

    /// 被邀请者拒绝邀请
    func onInviteeRejected(_ inviteID: String!, invitee: String!, data: String!) {

    }

    /// 邀请被取消
    func onInvitationCancelled(_ inviteID: String!, inviter: String!, data: String!) {

    }

    /// 邀请超时
    func onInvitationTimeout(_ inviteID: String!, inviteeList: [String]!) {

    }
}
