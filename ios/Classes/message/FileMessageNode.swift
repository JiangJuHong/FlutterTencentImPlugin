//
// Created by 蒋具宏 on 2020/10/27.
//

import Foundation
import ImSDK

class FileMessageNode: AbstractMessageNode {
    override func getV2TIMMessage(params: [String: Any]) -> V2TIMMessage {
        let filePath: String = getParam(params: params, paramKey: "filePath")!;
        let fileName: String = getParam(params: params, paramKey: "fileName")!;
        return V2TIMManager.sharedInstance().createFileMessage(filePath, fileName: fileName)
    }

    override func getNote(elem: V2TIMElem) -> String {
        "[文件]";
    }

    override func analysis(elem: V2TIMElem) -> AbstractMessageEntity {
        FileMessageEntity(elem: elem as! V2TIMFileElem)
    }
}
