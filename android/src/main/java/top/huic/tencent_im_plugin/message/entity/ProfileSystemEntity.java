package top.huic.tencent_im_plugin.message.entity;

import com.tencent.imsdk.TIMProfileSystemElem;

import java.util.HashMap;
import java.util.Map;

import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 用户资料变更系统通知实体
 */
public class ProfileSystemEntity extends AbstractMessageEntity {

    /**
     * 资料变更类型
     */
    private int subType;
    /**
     * 资料变更的用户名
     */
    private String fromUser;

    /**
     * 集合列表
     */
    private Map<String, Object> itemMap;

    public ProfileSystemEntity() {
        super(MessageNodeType.ProfileSystem);
    }

    public ProfileSystemEntity(TIMProfileSystemElem elem) {
        super(MessageNodeType.ProfileSystem);
        this.subType = elem.getSubType();
        this.fromUser = elem.getFromUser();
        this.itemMap = elem.getItemMap();
    }

    public int getSubType() {
        return subType;
    }

    public void setSubType(int subType) {
        this.subType = subType;
    }

    public String getFromUser() {
        return fromUser;
    }

    public void setFromUser(String fromUser) {
        this.fromUser = fromUser;
    }

    public Map<String, Object> getItemMap() {
        return itemMap;
    }

    public void setItemMap(Map<String, Object> itemMap) {
        this.itemMap = itemMap;
    }
}
