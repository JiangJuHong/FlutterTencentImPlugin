package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMMessage;
import com.tencent.imsdk.TIMSnapshot;
import com.tencent.imsdk.TIMTextElem;
import com.tencent.imsdk.TIMVideo;
import com.tencent.imsdk.TIMVideoElem;

import java.util.Map;

import top.huic.tencent_im_plugin.ValueCallBack;

/**
 * 视频消息节点
 */
public class VideoMessageNode extends AbstractMessageNode<TIMVideoElem> {
    @Override
    public void send(TIMConversation conversation, Map params, boolean ol, ValueCallBack<TIMMessage> onCallback) {
        // 封装消息对象
        TIMMessage message = new TIMMessage();
        TIMVideoElem videoElem = new TIMVideoElem();


        // 封装视频信息
        TIMVideo video = new TIMVideo();
        video.setType(super.getParam(params, "type").toString());
        video.setDuaration(Integer.parseInt(super.getParam(params, "duration").toString()));

        // 封装快照信息
        TIMSnapshot snapshot = new TIMSnapshot();
        snapshot.setWidth(Integer.parseInt(super.getParam(params, "snapshotWidth").toString()));
        snapshot.setHeight(Integer.parseInt(super.getParam(params, "snapshotHeight").toString()));

        videoElem.setSnapshot(snapshot);
        videoElem.setVideo(video);
        videoElem.setSnapshotPath(super.getParam(params, "snapshotPath").toString());
        videoElem.setVideoPath(super.getParam(params, "path").toString());
        message.addElement(videoElem);


        super.sendMessage(conversation, message, ol, onCallback);
    }

    @Override
    public String getNote(TIMVideoElem elem) {
        return "[视频]";
    }
}