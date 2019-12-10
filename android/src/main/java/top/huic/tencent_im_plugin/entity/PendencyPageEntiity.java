package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.friendship.TIMFriendPendencyResponse;

import java.util.ArrayList;
import java.util.List;

/**
 * 未决分页实体
 *
 * @author 蒋具宏
 */
public class PendencyPageEntiity {
    private long seq;
    private long timestamp;
    private long unreadCnt;
    private List<PendencyEntity> items = new ArrayList();

    public PendencyPageEntiity() {
    }

    public PendencyPageEntiity(TIMFriendPendencyResponse data) {
        seq = data.getSeq();
        timestamp = data.getTimestamp();
        unreadCnt = data.getUnreadCnt();
    }

    public long getSeq() {
        return seq;
    }

    public void setSeq(long seq) {
        this.seq = seq;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    public long getUnreadCnt() {
        return unreadCnt;
    }

    public void setUnreadCnt(long unreadCnt) {
        this.unreadCnt = unreadCnt;
    }

    public List<PendencyEntity> getItems() {
        return items;
    }

    public void setItems(List<PendencyEntity> items) {
        this.items = items;
    }
}
