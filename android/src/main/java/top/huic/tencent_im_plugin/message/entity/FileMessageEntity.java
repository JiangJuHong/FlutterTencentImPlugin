package top.huic.tencent_im_plugin.message.entity;

import com.tencent.imsdk.v2.V2TIMFileElem;

import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 文件消息实体
 */
public class FileMessageEntity extends AbstractMessageEntity {
    /**
     * 文件路径
     */
    private String filePath;

    /**
     * 文件名
     */
    private String fileName;

    /**
     * 文件UUID
     */
    private String uuid;

    /**
     * 文件大小
     */
    private int size;

    public FileMessageEntity() {
        super(MessageNodeType.File);
    }

    public FileMessageEntity(V2TIMFileElem elem) {
        super(MessageNodeType.File);
        this.setFileName(elem.getFileName());
        this.setFilePath(elem.getPath());
        this.setSize(elem.getFileSize());
        this.setUuid(elem.getUUID());
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }
}
