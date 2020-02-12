import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  声音节点
public class SoundNodeEntity : NodeEntity{
    
    /**
     * 时长
     */
    var duration : Int32?;
    
    /**
     *  路径
     */
    var path : String?;
    
    /**
     * 大小
     */
    var dataSize : Int32?;
    
    /**
     * 编号
     */
    var uuid : String?;
    
    /**
     * 任务ID
     */
    var taskId : UInt32?;
    
    override init() {
    }
    
    init(elem : TIMElem) {
        super.init();
        let soundElem = elem as! TIMSoundElem;
        self.duration = soundElem.second;
        self.path = soundElem.path;
        self.dataSize = soundElem.dataSize;
        self.uuid = soundElem.uuid;
        self.taskId = soundElem.taskId;
    }
}
