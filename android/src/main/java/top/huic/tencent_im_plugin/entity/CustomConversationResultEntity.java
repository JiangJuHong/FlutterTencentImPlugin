package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.v2.V2TIMConversation;
import com.tencent.imsdk.v2.V2TIMConversationResult;

import java.util.ArrayList;
import java.util.List;

import top.huic.tencent_im_plugin.util.BeanUtils;

/**
 * 自定义会话结果实体
 */
public class CustomConversationResultEntity {

    /**
     * 下一次分页拉取的游标
     */
    private Long nextSeq;

    /**
     * 会话列表是否已经拉取完毕
     */
    private Boolean finished;

    /**
     * 会话列表
     */
    private List<CustomConversationEntity> conversationList;

    public CustomConversationResultEntity() {
    }

    public CustomConversationResultEntity(V2TIMConversationResult data) {
        BeanUtils.copyProperties(data, this, "conversationList");

        if (data.getConversationList() != null) {
            List<CustomConversationEntity> conversationList = new ArrayList<>(data.getConversationList().size());
            for (V2TIMConversation item : data.getConversationList()) {
                conversationList.add(new CustomConversationEntity(item));
            }
            this.conversationList = conversationList;
        }
    }

    public Long getNextSeq() {
        return nextSeq;
    }

    public void setNextSeq(Long nextSeq) {
        this.nextSeq = nextSeq;
    }

    public Boolean getFinished() {
        return finished;
    }

    public void setFinished(Boolean finished) {
        this.finished = finished;
    }

    public List<CustomConversationEntity> getConversationList() {
        return conversationList;
    }

    public void setConversationList(List<CustomConversationEntity> conversationList) {
        this.conversationList = conversationList;
    }
}
