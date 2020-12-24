//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation
import ImSDK

/// 自定义信令监听
class CustomSignalingListener: NSObject, V2TIMSignalingListener {
    ///收到新邀请时
    func onReceiveNewInvitation(_ inviteID: String!, inviter: String!, groupID: String!, inviteeList: [String]!, data: String!) {
        var params: [String: Any] = [
            "inviteID": inviteID!,
            "data": data!,
        ];

        if let temp = inviter {
            params["inviter"] = temp;
        }
        if let temp = groupID {
            params["groupID"] = temp;
        }
        if let temp = inviteeList {
            params["inviteeList"] = temp;
        }


        SwiftTencentImPlugin.invokeListener(type: ListenerType.ReceiveNewInvitation, params: params)
    }


    /// 被邀请者接受邀请
    func onInviteeAccepted(_ inviteID: String!, invitee: String!, data: String!) {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.InviteeAccepted, params: [
            "inviteID": inviteID!,
            "invitee": invitee!,
            "data": data!,
        ])
    }

    /// 被邀请者拒绝邀请
    func onInviteeRejected(_ inviteID: String!, invitee: String!, data: String!) {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.InviteeRejected, params: [
            "inviteID": inviteID!,
            "invitee": invitee!,
            "data": data!,
        ])
    }

    /// 邀请被取消
    func onInvitationCancelled(_ inviteID: String!, inviter: String!, data: String!) {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.InvitationCancelled, params: [
            "inviteID": inviteID!,
            "inviter": inviter!,
            "data": data!,
        ])
    }

    /// 邀请超时
    func onInvitationTimeout(_ inviteID: String!, inviteeList: [String]!) {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.InvitationTimeout, params: [
            "inviteID": inviteID!,
            "inviteeList": inviteeList!,
        ])
    }
}
