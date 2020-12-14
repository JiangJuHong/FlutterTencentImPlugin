package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMGroupAtInfo;
import com.tencent.imsdk.v2.V2TIMManager;
import com.tencent.imsdk.v2.V2TIMMessage;
import com.tencent.imsdk.v2.V2TIMTextElem;

import java.util.ArrayList;
import java.util.List;

import top.huic.tencent_im_plugin.message.entity.TextMessageEntity;

/**
 * 文本消息节点
 */
public class TextMessageNode extends AbstractMessageNode<V2TIMTextElem, TextMessageEntity> {
    @Override
    public V2TIMMessage getV2TIMMessage(TextMessageEntity entity) {

        // 有@用户或者@所有人则进入分支
        if ((entity.getAtUserList() != null && entity.getAtUserList().size() >= 1) || (entity.getAtAll() != null && entity.getAtAll())) {
            List<String> atList = new ArrayList<>();
            // @所有人
            if (entity.getAtAll() != null && entity.getAtAll()) {
                atList.add(TIMGroupAtInfo.AT_ALL_TAG);
            }

            // @目标用户
            if (entity.getAtUserList() != null) {
                atList.addAll(entity.getAtUserList());
            }
            return V2TIMManager.getMessageManager().createTextAtMessage(entity.getContent(), atList);
        }
        return V2TIMManager.getMessageManager().createTextMessage(entity.getContent());
    }

    @Override
    public String getNote(V2TIMTextElem elem) {
        return elem.getText();
    }

    @Override
    public TextMessageEntity analysis(V2TIMTextElem elem) {
        return new TextMessageEntity(elem);
    }

    @Override
    public Class<TextMessageEntity> getEntityClass() {
        return TextMessageEntity.class;
    }
}