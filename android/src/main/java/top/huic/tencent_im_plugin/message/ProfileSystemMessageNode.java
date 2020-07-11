package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMProfileSystemElem;

import top.huic.tencent_im_plugin.message.entity.ProfileSystemEntity;


/**
 * 用户资料变更系统通知 节点
 */
public class ProfileSystemMessageNode extends AbstractMessageNode<TIMProfileSystemElem, ProfileSystemEntity> {

    @Override
    protected TIMMessage getSendMessage(ProfileSystemEntity entity) {
        throw new RuntimeException("This node does not support sending");
    }

    @Override
    public String getNote(TIMProfileSystemElem elem) {
        return "[用户资料变更]";
    }

    @Override
    public ProfileSystemEntity analysis(TIMProfileSystemElem elem) {
        return new ProfileSystemEntity(elem);
    }

    @Override
    public Class<ProfileSystemEntity> getEntityClass() {
        return ProfileSystemEntity.class;
    }
}