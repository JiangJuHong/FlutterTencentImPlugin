//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation
import ImSDK

class CustomFriendshipListener: NSObject, V2TIMFriendshipListener {
    /**
     * 好友申请新增通知，两种情况会收到这个回调：
     * <p>
     * 自己申请加别人好友
     * 别人申请加自己好友
     */
    func onFriendApplicationListAdded(_ applicationList: [V2TIMFriendApplication]!) {

    }


    /**
     * 好友申请删除通知，四种情况会收到这个回调
     * <p>
     * 调用 deleteFriendApplication 主动删除好友申请
     * 调用 refuseFriendApplication 拒绝好友申请
     * 调用 acceptFriendApplication 同意好友申请且同意类型为 V2TIM_FRIEND_ACCEPT_AGREE 时
     * 申请加别人好友被拒绝
     */
    func onFriendApplicationListDeleted(_ userIDList: [Any]!) {

    }


    /**
     * 好友申请已读通知，如果调用 setFriendApplicationRead 设置好友申请列表已读，会收到这个回调（主要用于多端同步）
     */
    func onFriendApplicationListRead() {

    }

    /**
     * 好友新增通知
     */
    func onFriendListAdded(_ infoList: [V2TIMFriendInfo]!) {

    }

    /**
     * 好友删除通知，，两种情况会收到这个回调：
     * <p>
     * 自己删除好友（单向和双向删除都会收到回调）
     * 好友把自己删除（双向删除会收到）
     */
    func onFriendListDeleted(_ userIDList: [Any]!) {

    }

    /**
     * 黑名单新增通知
     */
    func onBlackListAdded(_ infoList: [V2TIMFriendInfo]!) {

    }


    /**
     * 黑名单删除通知
     */
    func onBlackListDeleted(_ userIDList: [Any]!) {

    }


    /**
     * 好友资料更新通知
     */
    func onFriendProfileChanged(_ infoList: [V2TIMFriendInfo]!) {

    }
}
