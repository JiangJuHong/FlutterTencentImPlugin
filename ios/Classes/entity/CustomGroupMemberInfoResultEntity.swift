//
// Created by 蒋具宏 on 2020/10/29.
//

import Foundation
import ImSDK

class CustomGroupMemberInfoResultEntity: NSObject {
    /// 获取分页拉取的 seq。如果为 0 表示拉取结束。
    var nextSeq: UInt64?;

    /// 群成员信息
    var memberInfoList: [[String: Any]]?;

    override init() {
    }

    init(nextSeq: UInt64, infos: [V2TIMGroupMemberFullInfo]) {
        super.init();
        self.nextSeq = nextSeq;
        self.memberInfoList = [];
        for info in infos {
            self.memberInfoList!.append(CustomGroupMemberFullInfoEntity.getDict(info: info))
        }
    }
}
