package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.v2.V2TIMManager;
import com.tencent.imsdk.v2.V2TIMMessage;
import com.tencent.imsdk.v2.V2TIMVideoElem;

import top.huic.tencent_im_plugin.message.entity.VideoMessageEntity;

/**
 * 视频消息节点
 */
public class VideoMessageNode extends AbstractMessageNode<V2TIMVideoElem, VideoMessageEntity> {
    @Override
    public V2TIMMessage getV2TIMMessage(VideoMessageEntity entity) {
        String suffix = null;
        if (entity.getVideoPath().contains(".")) {
            String[] ss = entity.getVideoPath().split("\\.");
            suffix = ss[ss.length - 1];
        }
        return V2TIMManager.getMessageManager().createVideoMessage(entity.getVideoPath(), suffix, entity.getDuration(), entity.getSnapshotPath());
    }

    @Override
    public String getNote(V2TIMVideoElem elem) {
        return "[视频]";
    }

    @Override
    public VideoMessageEntity analysis(V2TIMVideoElem elem) {
        VideoMessageEntity entity = new VideoMessageEntity();
        entity.setVideoUuid(elem.getVideoUUID());
        entity.setVideoPath(elem.getVideoPath());
        entity.setVideoSize(elem.getVideoSize());
        entity.setDuration(elem.getDuration());
        entity.setSnapshotUuid(elem.getSnapshotUUID());
        entity.setSnapshotWidth(elem.getSnapshotWidth());
        entity.setSnapshotHeight(elem.getSnapshotHeight());
        entity.setSnapshotPath(elem.getSnapshotPath());
        entity.setSnapshotSize(elem.getSnapshotSize());
        return entity;
    }

    @Override
    public Class<VideoMessageEntity> getEntityClass() {
        return VideoMessageEntity.class;
    }
}