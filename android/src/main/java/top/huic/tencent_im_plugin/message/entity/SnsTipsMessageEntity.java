package top.huic.tencent_im_plugin.message.entity;

import com.tencent.imsdk.TIMSNSSystemElem;
import top.huic.tencent_im_plugin.enums.MessageNodeType;
import top.huic.tencent_im_plugin.enums.SnsTipsType;

/**
 * 关系链相关操作后，后台push同步下来的消息元素
 *
 * @author 蒋具宏
 */
public class SnsTipsMessageEntity extends AbstractMessageEntity {
    /**
     * 未决已读上报时间戳 type == TIMSNSSystemType.TIM_SNS_SYSTEM_PENDENCY_REPORT 时有效
     */
    private long pendencyReportTimestamp;

    /**
     * 子类型
     */
    private SnsTipsType subType;

    public SnsTipsMessageEntity(MessageNodeType nodeType) {
        super(MessageNodeType.SnsTips);
    }

    public SnsTipsMessageEntity(TIMSNSSystemElem elem) {
        super(MessageNodeType.SnsTips);
        this.pendencyReportTimestamp = elem.getPendencyReportTimestamp();
        this.subType = SnsTipsType.getSnsTipsTypeByValue(elem.getSubType());
    }

    public long getPendencyReportTimestamp() {
        return pendencyReportTimestamp;
    }

    public void setPendencyReportTimestamp(long pendencyReportTimestamp) {
        this.pendencyReportTimestamp = pendencyReportTimestamp;
    }

    public SnsTipsType getSubType() {
        return subType;
    }

    public void setSubType(SnsTipsType subType) {
        this.subType = subType;
    }
}