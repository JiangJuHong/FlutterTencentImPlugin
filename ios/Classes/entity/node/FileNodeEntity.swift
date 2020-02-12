import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  文件节点
public class FileNodeEntity : NodeEntity{
    
    /**
     * 文件名
     */
    var fileName : String?;
    
    /**
     * 文件大小
     */
    var fileSize : Int32?;
    
    /**
     * 获取上传文件所在路径，只对发送方有效
     */
    var path : String?
    
    /**
     * 任务ID
     */
    var taskId : UInt32?;
    
    /**
     * 获取uuid
     */
    var uuid : String?
    
    override init() {
    }
    
    init(elem : TIMElem) {
        super.init();
        let fileElem = elem as! TIMFileElem;
        self.fileName = fileElem.filename;
        self.fileSize = fileElem.fileSize;
        self.path = fileElem.path;
        self.taskId = fileElem.taskId;
        self.uuid = fileElem.uuid;
    }
}
