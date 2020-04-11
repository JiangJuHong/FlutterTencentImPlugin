package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMSnapshot;
import com.tencent.imsdk.TIMVideo;
import com.tencent.imsdk.TIMVideoElem;

import top.huic.tencent_im_plugin.message.entity.video.VideoInfo;
import top.huic.tencent_im_plugin.message.entity.video.VideoMessageEntity;
import top.huic.tencent_im_plugin.message.entity.video.VideoSnapshotInfo;

/**
 * 视频消息节点
 */
public class VideoMessageNode extends AbstractMessageNode<TIMVideoElem, VideoMessageEntity> {
    @Override
    protected TIMMessage getSendMessage(VideoMessageEntity entity) {
        // 封装消息对象
        TIMMessage message = new TIMMessage();
        TIMVideoElem videoElem = new TIMVideoElem();


        // 封装视频信息
        TIMVideo video = new TIMVideo();
        video.setType(entity.getVideoInfo().getType());
        video.setDuaration(entity.getVideoInfo().getDuration());

        // 封装快照信息
        TIMSnapshot snapshot = new TIMSnapshot();
        snapshot.setWidth(entity.getVideoSnapshotInfo().getWidth());
        snapshot.setHeight(entity.getVideoSnapshotInfo().getHeight());

        videoElem.setSnapshot(snapshot);
        videoElem.setVideo(video);
        videoElem.setSnapshotPath(entity.getVideoSnapshotInfo().getPath());
        videoElem.setVideoPath(entity.getVideoInfo().getPath());
        message.addElement(videoElem);
        return message;
    }

    @Override
    public String getNote(TIMVideoElem elem) {
        return "[视频]";
    }

    @Override
    public VideoMessageEntity analysis(TIMVideoElem elem) {
        VideoMessageEntity entity = new VideoMessageEntity();
        VideoInfo videoInfo = new VideoInfo();
        VideoSnapshotInfo videoSnapshotInfo = new VideoSnapshotInfo();

        videoInfo.setPath(elem.getVideoPath());
        videoInfo.setDuration(elem.getVideoInfo().getDuaration());
        videoInfo.setSize(elem.getVideoInfo().getSize());
        videoInfo.setType(elem.getVideoInfo().getType());
        videoInfo.setUuid(elem.getVideoInfo().getUuid());

        videoSnapshotInfo.setPath(elem.getSnapshotPath());
        videoSnapshotInfo.setHeight(elem.getSnapshotInfo().getHeight());
        videoSnapshotInfo.setWidth(elem.getSnapshotInfo().getWidth());
        videoSnapshotInfo.setSize(elem.getSnapshotInfo().getSize());
        videoSnapshotInfo.setUuid(elem.getSnapshotInfo().getUuid());

        entity.setVideoInfo(videoInfo);
        entity.setVideoSnapshotInfo(videoSnapshotInfo);
        return entity;
    }

    @Override
    public Class<VideoMessageEntity> getEntityClass() {
        return VideoMessageEntity.class;
    }
}