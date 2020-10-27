package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.v2.V2TIMLocationElem;
import com.tencent.imsdk.v2.V2TIMManager;
import com.tencent.imsdk.v2.V2TIMMessage;

import top.huic.tencent_im_plugin.message.entity.LocationMessageEntity;

/**
 * 位置消息节点
 */
public class LocationMessageNode extends AbstractMessageNode<V2TIMLocationElem, LocationMessageEntity> {
    @Override
    public V2TIMMessage getV2TIMMessage(LocationMessageEntity entity) {
        return V2TIMManager.getMessageManager().createLocationMessage(entity.getDesc(), entity.getLongitude(), entity.getLatitude());
    }

    @Override
    public String getNote(V2TIMLocationElem elem) {
        return "[位置消息]";
    }

    @Override
    public LocationMessageEntity analysis(V2TIMLocationElem elem) {
        return new LocationMessageEntity(elem);
    }

    @Override
    public Class<LocationMessageEntity> getEntityClass() {
        return LocationMessageEntity.class;
    }
}