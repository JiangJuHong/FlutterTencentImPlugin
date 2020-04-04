package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMLocationElem;
import com.tencent.imsdk.TIMMessage;

import top.huic.tencent_im_plugin.message.entity.LocationMessageEntity;

/**
 * 位置消息节点
 */
public class LocationMessageNode extends AbstractMessageNode<TIMLocationElem, LocationMessageEntity> {
    @Override
    protected TIMMessage getSendMessage(LocationMessageEntity entity) {
        TIMMessage message = new TIMMessage();
        TIMLocationElem locationElem = new TIMLocationElem();
        locationElem.setDesc(entity.getDesc());
        locationElem.setLatitude(entity.getLatitude());
        locationElem.setLongitude(entity.getLongitude());
        message.addElement(locationElem);
        return message;
    }

    @Override
    public String getNote(TIMLocationElem elem) {
        return "[位置消息]";
    }

    @Override
    public LocationMessageEntity analysis(TIMLocationElem elem) {
        LocationMessageEntity entity = new LocationMessageEntity();
        entity.setDesc(elem.getDesc());
        entity.setLongitude(elem.getLongitude());
        entity.setLatitude(elem.getLatitude());
        return entity;
    }

    @Override
    public Class<LocationMessageEntity> getEntityClass() {
        return LocationMessageEntity.class;
    }
}