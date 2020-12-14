package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.v2.V2TIMFaceElem;
import com.tencent.imsdk.v2.V2TIMManager;
import com.tencent.imsdk.v2.V2TIMMessage;

import top.huic.tencent_im_plugin.message.entity.FaceMessageEntity;

/**
 * 表情消息节点
 */
public class FaceMessageNode extends AbstractMessageNode<V2TIMFaceElem, FaceMessageEntity> {

    @Override
    public V2TIMMessage getV2TIMMessage(FaceMessageEntity entity) {
        return V2TIMManager.getMessageManager().createFaceMessage(entity.getIndex(), entity.getData().getBytes());
    }

    @Override
    public String getNote(V2TIMFaceElem elem) {
        return "[表情]";
    }

    @Override
    public FaceMessageEntity analysis(V2TIMFaceElem elem) {
        return new FaceMessageEntity(elem);
    }

    @Override
    public Class<FaceMessageEntity> getEntityClass() {
        return FaceMessageEntity.class;
    }
}
