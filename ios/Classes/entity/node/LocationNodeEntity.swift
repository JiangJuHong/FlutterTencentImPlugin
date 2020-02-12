import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  位置节点
public class LocationNodeEntity : NodeEntity{
    
    /**
     * 位置描述
     */
    var desc : String?;
    
    /**
     * 纬度
     */
    var latitude : Double?;
    
    /**
     * 经度
     */
    var longitude : Double?;
    
    override init() {
    }
    
    init(elem : TIMElem) {
        super.init();
        let locationElem = elem as! TIMLocationElem;
        self.desc = locationElem.desc;
        self.latitude = locationElem.latitude;
        self.longitude = locationElem.longitude;
    }
}
