//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation

/// 文件消息实体
class FileMessageEntity: AbstractMessageEntity {
    /**
     * 文件路径
     */
    var filePath: String?;

    /**
     * 文件名
     */
    var fileName: String?;

    /**
     * 文件UUID
     */
    var uuid: String?;

    /**
     * 文件大小
     */
    var size: Int32?;

    override init() {
        super.init(MessageNodeType.File);
    }
}
