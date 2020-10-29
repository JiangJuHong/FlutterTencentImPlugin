package top.huic.tencent_im_plugin.message.entity;

import com.tencent.imsdk.v2.V2TIMTextElem;

import java.util.List;

import top.huic.tencent_im_plugin.enums.MessageNodeType;

/**
 * 文本消息实体
 *
 * @author 蒋具宏
 */
public class TextMessageEntity extends AbstractMessageEntity {
    /**
     * 消息内容
     */
    private String content;

    /**
     * \@的用户列表
     */
    private List<String> atUserList;

    /**
     * 是否@所有人
     */
    private Boolean atAll;

    public TextMessageEntity() {
        super(MessageNodeType.Text);
    }

    public TextMessageEntity(V2TIMTextElem elem) {
        super(MessageNodeType.Text);
        this.content = elem.getText();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public List<String> getAtUserList() {
        return atUserList;
    }

    public void setAtUserList(List<String> atUserList) {
        this.atUserList = atUserList;
    }

    public Boolean getAtAll() {
        return atAll;
    }

    public void setAtAll(Boolean atAll) {
        this.atAll = atAll;
    }
}