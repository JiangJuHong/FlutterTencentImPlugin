package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.ext.group.TIMGroupPendencyMeta;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 群未决分页实体
 *
 * @author 蒋具宏
 */
public class GroupPendencyPageEntiity implements Serializable {

    private long nextStartTimestamp;

    private long reportedTimestamp;

    private long unReadCount;

    private List<GroupPendencyEntity> items;

    public GroupPendencyPageEntiity(TIMGroupPendencyMeta pendencyMeta, List<GroupPendencyEntity> resultData) {
        this.nextStartTimestamp = pendencyMeta.getNextStartTimestamp();
        this.reportedTimestamp = pendencyMeta.getReportedTimestamp();
        this.unReadCount = pendencyMeta.getUnReadCount();
        this.items = resultData;
        if (this.items == null) {
            items = new ArrayList<>();
        }
    }

    public long getNextStartTimestamp() {
        return nextStartTimestamp;
    }

    public void setNextStartTimestamp(long nextStartTimestamp) {
        this.nextStartTimestamp = nextStartTimestamp;
    }

    public long getReportedTimestamp() {
        return reportedTimestamp;
    }

    public void setReportedTimestamp(long reportedTimestamp) {
        this.reportedTimestamp = reportedTimestamp;
    }

    public long getUnReadCount() {
        return unReadCount;
    }

    public void setUnReadCount(long unReadCount) {
        this.unReadCount = unReadCount;
    }

    public List<GroupPendencyEntity> getItems() {
        return items;
    }

    public void setItems(List<GroupPendencyEntity> items) {
        this.items = items;
    }
}
