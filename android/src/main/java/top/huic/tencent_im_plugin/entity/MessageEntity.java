package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.TIMUserProfile;

/**
 * 消息实体
 *
 * @author 蒋具宏
 */
public class MessageEntity {
    /**
     * 消息ID
     */
    private String id;

    /**
     * 消息内容
     */
    private String content;

    /**
     * 用户资料信息
     */
    private TIMUserProfile info;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public TIMUserProfile getInfo() {
        return info;
    }

    public void setInfo(TIMUserProfile info) {
        this.info = info;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
