//
// Created by 蒋具宏 on 2020/10/29.
//

import Foundation
import ImSDK

/// 自定义会话结果实体
class CustomConversationResultEntity: NSObject {
    /// 下一次分页拉取的游标
    var nextSeq: UInt64?;

    /// 是否拉取完毕
    var finished: Bool?;

    /// 会话列表
    var conversationList: [[String: Any]]?;

    required public override init() {
    }

    init(conversations: [V2TIMConversation], nextSeq: UInt64, finished: Bool) {
        super.init();
        self.nextSeq = nextSeq;
        self.finished = finished;
        conversationList = [];
        for item in conversations {
            conversationList!.append(CustomConversationEntity.getDict(info: item));
        }
    }
}
