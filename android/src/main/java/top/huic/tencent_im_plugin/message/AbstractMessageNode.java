package top.huic.tencent_im_plugin.message;

import com.tencent.imsdk.TIMConversation;
import com.tencent.imsdk.TIMElem;
import com.tencent.imsdk.TIMMessage;

import java.util.Map;

import top.huic.tencent_im_plugin.ValueCallBack;

/**
 * 消息节点接口
 *
 * @param <N> 节点类型，对应腾讯云 TIMElem
 */
public abstract class AbstractMessageNode<N, E> {
    /**
     * 发送消息
     *
     * @param conversation 会话
     * @param onCallback   结果回调
     * @param entity       实体
     * @param ol           是否在线消息
     */
    public abstract void send(TIMConversation conversation, E entity, boolean ol, ValueCallBack<TIMMessage> onCallback);

    /**
     * 根据消息节点获得描述
     *
     * @param elem 节点
     */
    public abstract String getNote(N elem);

    /**
     * 发送消息
     *
     * @param conversation 会话
     * @param message      消息内容
     * @param ol           是否使用在线消息发送
     * @param onCallback   结果回调
     */
    void sendMessage(TIMConversation conversation, TIMMessage message, boolean ol, ValueCallBack<TIMMessage> onCallback) {
        if (ol) {
            conversation.sendOnlineMessage(message, onCallback);
        } else {
            conversation.sendMessage(message, onCallback);
        }
    }

    /**
     * 获得实体类型
     *
     * @return 类型
     */
    public abstract Class<E> getEntityClass();
}