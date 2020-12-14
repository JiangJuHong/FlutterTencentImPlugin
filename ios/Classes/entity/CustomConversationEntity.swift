//
// Created by 蒋具宏 on 2020/10/29.
//

import Foundation
import ImSDK

/// 自定义会话实体
class CustomConversationEntity: V2TIMConversation {


    /// 根据对象获得字典对象
    public static func getDict(info: V2TIMConversation) -> [String: Any] {
        var result: [String: Any] = [:];
        result["conversationID"] = info.conversationID;
        result["type"] = info.type.rawValue;
        result["userID"] = info.userID;
        result["groupID"] = info.groupID;
        result["showName"] = info.showName;
        result["faceUrl"] = info.faceUrl;
        result["recvOpt"] = info.recvOpt.rawValue;
        result["groupType"] = info.groupType;
        result["unreadCount"] = info.unreadCount;
        result["lastMessage"] = MessageEntity.init(message: info.lastMessage);
        result["draftText"] = info.draftText;
        result["draftText"] = info.draftText;
        result["draftTimestamp"] = info.draftTimestamp;
        result["test"] = nil;
        if info.groupAtInfolist != nil {
            var groupAtInfoList: [[String: Any]] = [];
            for item in info.groupAtInfolist {
                groupAtInfoList.append(CustomGroupAtInfoEntity.getDict(info: item));
            }
            result["groupAtInfoList"] = groupAtInfoList;
        }
        return result;
    }
}
