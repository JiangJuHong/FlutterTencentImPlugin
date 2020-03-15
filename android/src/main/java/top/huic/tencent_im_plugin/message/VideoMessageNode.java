package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMSnapshot;
import com.tencent.imsdk.TIMTextElem;
import com.tencent.imsdk.TIMVideo;
import com.tencent.imsdk.TIMVideoElem;

import java.util.Map;

import top.huic.tencent_im_plugin.ValueCallBack;
import top.huic.tencent_im_plugin.message.entity.VideoMessageEntity;

/**
 * 视频消息节点
 */
public class VideoMessageNode extends AbstractMessageNode<TIMVideoElem, VideoMessageEntity> {
    @Override
    public void send(TIMConversation conversation, VideoMessageEntity entity, boolean ol, ValueCallBack<TIMMessage> onCallback) {
        // 封装消息对象
        TIMMessage message = new TIMMessage();
        TIMVideoElem videoElem = new TIMVideoElem();


        // 封装视频信息
        TIMVideo video = new TIMVideo();
        video.setType(entity.getType());
        video.setDuaration(entity.getDuration());

        // 封装快照信息
        TIMSnapshot snapshot = new TIMSnapshot();
        snapshot.setWidth(entity.getSnapshotWidth());
        snapshot.setHeight(entity.getSnapshotHeight());

        videoElem.setSnapshot(snapshot);
        videoElem.setVideo(video);
        videoElem.setSnapshotPath(entity.getSnapshotPath());
        videoElem.setVideoPath(entity.getPath());
        message.addElement(videoElem);


        super.sendMessage(conversation, message, ol, onCallback);
    }

    @Override
    public String getNote(TIMVideoElem elem) {
        return "[视频]";
    }

    @Override
    public Class<VideoMessageEntity> getEntityClass() {
        return VideoMessageEntity.class;
    }
}