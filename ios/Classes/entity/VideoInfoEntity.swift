import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  视频信息
public class VideoInfoEntity : NSObject{
    
    /**
     * 时长
     */
    var duaration : Int32?;
    
    /**
     * 大小
     */
    var size : Int32?;
    
    /**
     * 类型
     */
    var type : String?;
    
    /**
     * Uuid
     */
    var uuid : String?;
    
    override init() {
    }
    
    init(video : TIMVideo) {
        super.init();
        self.duaration = video.duration;
        self.size = video.size;
        self.type = video.type;
        self.uuid = video.uuid;
    }
}
