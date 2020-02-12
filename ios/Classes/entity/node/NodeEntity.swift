import ImSDK

//  Created by 蒋具宏 on 2020/2/12.
//  所有节点最上层
public class NodeEntity : NSObject{
    
    /**
     * 节点类型
     */
    var type : NodeType?;
    
    /**
     * 根据腾讯云节点获得节点对象
     */
    static func getNodeEntityByTIMElem(elem : TIMElem)->NodeEntity{
        var entity : NodeEntity = NodeEntity();
        if elem is TIMTextElem{
            entity = TextNodeEntity(elem: elem);
        }else if elem is TIMCustomElem{
            entity = CustomNodeEntity(elem:elem);
        }else if elem is TIMSoundElem{
            entity = SoundNodeEntity(elem:elem);
        }else if elem is TIMImageElem{
            entity = ImageNodeEntity(elem:elem);
        }else if elem is TIMFaceElem{
            entity = FaceNodeEntity(elem:elem);
        }else if elem is TIMFileElem{
            entity = FileNodeEntity(elem:elem);
        }else if elem is TIMGroupSystemElem{
            entity = GroupSystemNodeEntity(elem:elem);
        }else if elem is TIMGroupTipsElem{
            entity = GroupTipsNodeEntity(elem:elem);
        }else if elem is TIMLocationElem{
            entity = LocationNodeEntity(elem:elem);
        }else if elem is TIMProfileSystemElem{
            entity = ProfileSystemNodeEntity(elem:elem);
        }else if elem is TIMSNSSystemElem{
            entity = SNSSystemNodeEntity(elem:elem);
        }else if elem is TIMVideo{
            entity = VideoNodeEntity(elem:elem);
        }else{
            entity = NodeEntity();
        }
        
        entity.type = NodeType.getByTIMElem(elem: elem);
        return entity;
    }
}
