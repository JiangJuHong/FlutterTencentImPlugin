package top.huic.tencent_im_plugin.message.entity;

/**
 * 位置消息实体
 *
 * @author 蒋具宏
 */
public class LocationMessageEntity {
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