import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  缩略图信息
public class SnapshotInfoEntity : NSObject{
    
    /**
     * 大小
     */
    var size : Int32?;
    
    /**
    * 宽度
    */
    var width : Int32?;
    
    /**
    * 类型
    */
    var type : String?;
    
    /**
    * UUID
    */
    var uuid : String?;
    
    /**
    * 高度
    */
    var height : Int32?;
    
    override init() {
    }
    
    init(snapshot : TIMSnapshot) {
        super.init();
        self.size = snapshot.size;
        self.width = snapshot.width;
        self.type = snapshot.type;
        self.uuid = snapshot.uuid;
        self.height = snapshot.height;
    }
}
