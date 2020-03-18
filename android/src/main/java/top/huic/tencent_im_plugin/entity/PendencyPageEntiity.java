package top.huic.tencent_im_plugin.entity;

import com.tencent.imsdk.friendship.TIMFriendPendencyResponse;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 未决分页实体
 *
 * @author 蒋具宏
 */
public class PendencyPageEntiity implements Serializable {
    private long seq;
    private long timestamp;
    private long unreadCnt;
    private List<PendencyEntity> items;

    public PendencyPageEntiity(TIMFriendPendencyResponse data, List<PendencyEntity> items) {
        seq = data.getSeq();
        timestamp = data.getTimestamp();
        unreadCnt = data.getUnreadCnt();
        this.items = items;
        if (this.items == null) {
            this.items = new ArrayList<>();
        }
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
