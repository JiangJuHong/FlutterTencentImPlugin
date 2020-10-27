//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation
import ImSDK

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

    init(elem: V2TIMFaceElem) {
        super.init(MessageNodeType.Face);
        self.index = elem.index;
        self.data = elem.data;
    }
}
