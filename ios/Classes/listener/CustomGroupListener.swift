//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation
import ImSDK

/// 群监听器
class CustomGroupListener: NSObject, V2TIMGroupListener {
    /// 有用户加入群（全员能够收到）
    func onMemberEnter(_ groupID: String!, memberList: [V2TIMGroupMemberInfo]!) {
        var data: [[String: Any]] = [];
        for item in memberList! {
            data.append(CustomGroupMemberFullInfoEntity.getDict(simpleInfo: item));
        }
        SwiftTencentImPlugin.invokeListener(type: ListenerType.MemberEnter, params: [
            "groupID": groupID,
            "memberList": data,
        ])
    }

    /// 有用户离开群（全员能够收到）
    func onMemberLeave(_ groupID: String!, member: V2TIMGroupMemberInfo!) {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.MemberLeave, params: [
            "groupID": groupID,
            "member": CustomGroupMemberFullInfoEntity.getDict(simpleInfo: member!),
        ])
    }


    /// 某些人被拉入某群（全员能够收到）
    func onMemberInvited(_ groupID: String!, opUser: V2TIMGroupMemberInfo!, memberList: [V2TIMGroupMemberInfo]!) {
        var data: [[String: Any]] = [];
        for item in memberList! {
            data.append(CustomGroupMemberFullInfoEntity.getDict(simpleInfo: item));
        }
        SwiftTencentImPlugin.invokeListener(type: ListenerType.MemberInvited, params: [
            "groupID": groupID,
            "memberList": data,
            "opUser": CustomGroupMemberFullInfoEntity.getDict(simpleInfo: opUser!),
        ])
    }

    /// 某些人被踢出某群（全员能够收到）
    func onMemberKicked(_ groupID: String!, opUser: V2TIMGroupMemberInfo!, memberList: [V2TIMGroupMemberInfo]!) {
        var data: [[String: Any]] = [];
        for item in memberList! {
            data.append(CustomGroupMemberFullInfoEntity.getDict(simpleInfo: item));
        }
        SwiftTencentImPlugin.invokeListener(type: ListenerType.MemberKicked, params: [
            "groupID": groupID,
            "memberList": data,
            "opUser": CustomGroupMemberFullInfoEntity.getDict(simpleInfo: opUser!),
        ])
    }

    /// 群成员信息被修改（全员能收到）
    func onMemberInfoChanged(_ groupID: String!, changeInfoList: [V2TIMGroupMemberChangeInfo]!) {
        var data: [[String: Any]] = [];
        print("=======================")
        print("=======================")
        print("onMemberInfoChanged 回调由于 v5.1.1 存在错误，暂不支持!");
        print("=======================")
        print("=======================")


//        for item in changeInfoList! {
//            data.append(CustomGroupMemberChangeInfoEntity.getDict(info: item));
//        }
//        SwiftTencentImPlugin.invokeListener(type: ListenerType.MemberInfoChanged, params: [
//            "groupID": groupID!,
//            "changInfo": data,
//        ])
    }

    /// 创建群（主要用于多端同步）
    func onGroupCreated(_ groupID: String!) {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.GroupCreated, params: groupID)
    }

    /// 群被解散了（全员能收到）
    func onGroupDismissed(_ groupID: String!, opUser: V2TIMGroupMemberInfo!) {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.GroupDismissed, params: [
            "groupID": groupID,
            "opUser": CustomGroupMemberFullInfoEntity.getDict(simpleInfo: opUser),
        ])
    }

    /// 群被回收（全员能收到）
    func onGroupRecycled(_ groupID: String!, opUser: V2TIMGroupMemberInfo!) {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.GroupRecycled, params: [
            "groupID": groupID,
            "opUser": CustomGroupMemberFullInfoEntity.getDict(simpleInfo: opUser),
        ])
    }

    /// 群信息被修改（全员能收到）
    func onGroupInfoChanged(_ groupID: String!, changeInfoList: [V2TIMGroupChangeInfo]!) {
        var data: [[String: Any]] = [];
        for item in changeInfoList! {
            data.append(CustomGroupChangeInfoEntity.getDict(info: item));
        }
        SwiftTencentImPlugin.invokeListener(type: ListenerType.GroupInfoChanged, params: [
            "groupID": groupID,
            "changInfo": data,
        ])
    }

    /// 有新的加群请求（只有群主或管理员会收到）
    func onReceiveJoinApplication(_ groupID: String!, member: V2TIMGroupMemberInfo!, opReason: String!) {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.ReceiveJoinApplication, params: [
            "groupID": groupID,
            "member": CustomGroupMemberFullInfoEntity.getDict(simpleInfo: member),
            "opReason": opReason,
        ])
    }

    /// 加群请求已经被群主或管理员处理了（只有申请人能够收到）
    func onApplicationProcessed(_ groupID: String!, opUser: V2TIMGroupMemberInfo!, opResult isAgreeJoin: Bool, opReason: String!) {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.ApplicationProcessed, params: [
            "groupID": groupID,
            "opUser": CustomGroupMemberFullInfoEntity.getDict(simpleInfo: opUser),
            "isAgreeJoin": isAgreeJoin,
            "opReason": opReason,
        ])
    }

    /// 指定管理员身份
    func onGrantAdministrator(_ groupID: String!, opUser: V2TIMGroupMemberInfo!, memberList: [V2TIMGroupMemberInfo]!) {
        var data: [[String: Any]] = [];
        for item in memberList! {
            data.append(CustomGroupMemberFullInfoEntity.getDict(simpleInfo: item));
        }
        SwiftTencentImPlugin.invokeListener(type: ListenerType.GrantAdministrator, params: [
            "groupID": groupID,
            "opUser": CustomGroupMemberFullInfoEntity.getDict(simpleInfo: opUser),
            "memberList": data,
        ])
    }

    /// 取消管理员身份
    func onRevokeAdministrator(_ groupID: String!, opUser: V2TIMGroupMemberInfo!, memberList: [V2TIMGroupMemberInfo]!) {
        var data: [[String: Any]] = [];
        for item in memberList! {
            data.append(CustomGroupMemberFullInfoEntity.getDict(simpleInfo: item));
        }
        SwiftTencentImPlugin.invokeListener(type: ListenerType.RevokeAdministrator, params: [
            "groupID": groupID,
            "opUser": CustomGroupMemberFullInfoEntity.getDict(simpleInfo: opUser),
            "memberList": data,
        ])
    }

    /// 主动退出群组（主要用于多端同步，直播群（AVChatRoom）不支持）
    func onQuit(fromGroup groupID: String!) {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.QuitFromGroup, params: groupID)
    }

    /// 收到 RESTAPI 下发的自定义系统消息
    func onReceiveRESTCustomData(_ groupID: String!, data: Data!) {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.ReceiveRESTCustomData, params: [
            "groupID": groupID,
            "customData": data,
        ])
    }

    /// 收到群属性更新的回调
    func onGroupAttributeChanged(_ groupID: String!, attributes: NSMutableDictionary!) {
        SwiftTencentImPlugin.invokeListener(type: ListenerType.GroupAttributeChanged, params: [
            "groupID": groupID,
            "attributes": attributes,
        ])
    }
}