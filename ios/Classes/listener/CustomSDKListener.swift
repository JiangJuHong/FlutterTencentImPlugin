//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation
import ImSDK

/// 自定义SDK监听器
class CustomSDKListener: NSObject, V2TIMSDKListener {
    /// 连接中
    public func onConnecting() {
    }

    /// 网络连接成功
    public func onConnectSuccess() {
    }

    /// 网络连接失败
    public func onConnectFailed(_ code: Int32, err: String!) {
    }

    /// 踢下线通知
    public func onKickedOffline() {

    }

    /// 用户登录的 userSig 过期（用户需要重新获取 userSig 后登录）
    public func onUserSigExpired() {

    }

    /// 当前用户的资料发生了更新
    public func onSelfInfoUpdated(_ Info: V2TIMUserFullInfo!) {

    }
}
