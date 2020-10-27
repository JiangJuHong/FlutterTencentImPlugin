//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation

/// 表情消息实体
class FaceMessageEntity: AbstractMessageEntity {
    /**
    * 下标
    */
    var index: Int32?;

    /**
     * 文件名
     */
    var data: Data?;

    override init() {
        super.init(MessageNodeType.Face);
    }
}
