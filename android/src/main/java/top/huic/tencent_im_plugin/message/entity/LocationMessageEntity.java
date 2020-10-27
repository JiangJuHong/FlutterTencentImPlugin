package top.huic.tencent_im_plugin.message.entity;

import com.tencent.imsdk.v2.V2TIMLocationElem;

import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 位置消息实体
 *
 * @author 蒋具宏
 */
public class LocationMessageEntity extends AbstractMessageEntity {
    /**
     * 描述
     */
    private String desc;

    /**
     * 经度
     */
    private double latitude;

    /**
     * 纬度
     */
    private double longitude;

    public LocationMessageEntity() {
        super(MessageNodeType.Location);
    }

    public LocationMessageEntity(V2TIMLocationElem elem) {
        super(MessageNodeType.Location);
        this.setDesc(elem.getDesc());
        this.setLongitude(elem.getLongitude());
        this.setLatitude(elem.getLatitude());
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
}