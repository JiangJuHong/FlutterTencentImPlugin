package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.v2.V2TIMFileElem;
import com.tencent.imsdk.v2.V2TIMManager;
import com.tencent.imsdk.v2.V2TIMMessage;

import top.huic.tencent_im_plugin.message.entity.FileMessageEntity;

/**
 * 文件消息节点
 */
public class FileMessageNode extends AbstractMessageNode<V2TIMFileElem, FileMessageEntity> {
    @Override
    public V2TIMMessage getV2TIMMessage(FileMessageEntity entity) {
        return V2TIMManager.getMessageManager().createFileMessage(entity.getFilePath(), entity.getFileName());
    }

    @Override
    public String getNote(V2TIMFileElem elem) {
        return "[文件]";
    }

    @Override
    public FileMessageEntity analysis(V2TIMFileElem elem) {
        return new FileMessageEntity(elem);
    }

    @Override
    public Class<FileMessageEntity> getEntityClass() {
        return FileMessageEntity.class;
    }
}
