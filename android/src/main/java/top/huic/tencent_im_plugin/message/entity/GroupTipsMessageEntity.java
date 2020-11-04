package top.huic.tencent_im_plugin.message.entity;

import com.tencent.imsdk.v2.V2TIMGroupTipsElem;
import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 群提示消息实体
 *
 * @author 蒋具宏
 */
public class GroupTipsMessageEntity extends AbstractMessageEntity {
    public GroupTipsMessageEntity() {
        super(MessageNodeType.GroupTips);
    }

    public GroupTipsMessageEntity(V2TIMGroupTipsElem elem){
        super(MessageNodeType.GroupTips);
    }
}